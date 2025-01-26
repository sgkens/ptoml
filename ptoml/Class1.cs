using Tomlyn;
using Tomlyn.Model;
using System.Collections;

namespace Ptoml {
    public class TomlParser {

        private TomlTable _tomlObject;

        public TomlParser() => _tomlObject = new TomlTable(true);

        public void FromToml(string tomlString) => _tomlObject = Toml.ToModel(tomlString) as TomlTable ?? new TomlTable(true);

        public String ToToml() => Toml.FromModel(_tomlObject);

        public TomlTable ToTomlTable() => _tomlObject;

        public void PurgeTableData(){
            _tomlObject = new TomlTable(true);
        }

        public void ImportTableData(TomlTable tomlTable){
            _tomlObject = tomlTable;
        }

        public TomlTable GetProperty(string propertyName){
            if (propertyName.Contains('.')){
                var tomlKeys = propertyName.Split('.'); // Split the property name into parts
                TomlTable currentTable = _tomlObject;   // Start with the root TomlTable

                // Traverse through the nested keys
                foreach (var key in tomlKeys){
                    if (currentTable.ContainsKey(key)){
                        var value = currentTable[key];

                        // If the current value is another TomlTable, continue traversing
                        if (value is TomlTable nextTable){
                            currentTable = nextTable;
                        }
                        // if the current value is not a TomlTable, create a new TomlTable for it
                        // return new tomltable with key and value
                        else{
                            currentTable = new TomlTable(true);
                            currentTable.Add(key, value);
                        }
                    }else{
                        throw new KeyNotFoundException($"Key '{key}' not found in the TOML structure.");
                    }
                }

                // Return the final nested TomlTable after traversing
                return currentTable;
            }else{
                // Handle case where there is no dot notation (single key)
                TomlTable requestedProperty = new TomlTable(true);
                foreach (var key in _tomlObject.Keys){
                    if (key == propertyName){
                        if(_tomlObject[key].GetType().Name == "TomlTable"){
                            requestedProperty = _tomlObject[key] as TomlTable ?? new TomlTable(true);
                        }
                        else{
                            requestedProperty.Add(key, _tomlObject[key]);
                        }
                    }
                }
                return requestedProperty;
            }
        }

        public TomlTable ExtractProperty(string propertyName)
        {
            TomlTable ExtractedProperty = new TomlTable(true);

            if (_tomlObject.ContainsKey(propertyName))
            {
                ExtractedProperty.Add(propertyName, _tomlObject[propertyName]);
                return ExtractedProperty;
            }

            throw new KeyNotFoundException($"Property '{propertyName}' not found in the TOML TomlTable.");
        }

        public void AddProperty(string propertyName, object propertyValue)
        {
            // Split the property name into parts (supports nested structures like "database.host.port")
            var tomlKeys = propertyName.Split('.');

            // Start with the root TomlTable
            TomlTable currentTable = _tomlObject;

            // Traverse the keys except for the last one
            for (int i = 0; i < tomlKeys.Length - 1; i++){
                string key = tomlKeys[i];

                // If the current key exists and is a TomlTable, continue traversing
                if (currentTable.ContainsKey(key)){
                    if (currentTable[key] is TomlTable nextTable){
                        currentTable = nextTable;  // Move to the next level
                    }else{
                        throw new Exception($"Key '{key}' exists but is not a TomlTable.");
                    }
                }else{
                    // If the key doesn't exist, create a new TomlTable for it
                    var newTable = new TomlTable(true);
                    currentTable.Add(key, newTable);
                    currentTable = newTable;  // Move to the newly created table
                }
            }

            // Last level, add the property here
            string finalKey = tomlKeys.Last();

            // Handle the case where the value is a Hashtable (convert it to TomlTable recursively)
            if (propertyValue is Hashtable hashtable){
                var convertedTomlTable = HashtableToTomlTable(hashtable);
                currentTable.Add(finalKey, convertedTomlTable);  // Add the converted TomlTable
            }else{
                // Add the property directly if it is not a Hashtable
                currentTable.Add(finalKey, propertyValue);
            }
        }

        public void SetProperty(string propertyName, object propertyValue){
            // Split the property name into parts (supports nested structures like "database.host.port")
            var tomlKeys = propertyName.Split('.');

            // Start with the root TomlTable
            TomlTable currentTable = _tomlObject;

            // Traverse the keys except for the last one
            for (int i = 0; i < tomlKeys.Length - 1; i++){
                string key = tomlKeys[i];

                // If the current key exists and is a TomlTable, continue traversing
                if (currentTable.ContainsKey(key)){
                    if (currentTable[key] is TomlTable nextTable){
                        currentTable = nextTable;  // Move to the next level
                    }else{
                        throw new Exception($"Key '{key}' exists but is not a TomlTable.");
                    }
                }else{
                    // If the key doesn't exist, create a new TomlTable for it
                    var newTable = new TomlTable(true);
                    currentTable.Add(key, newTable);
                    currentTable = newTable;  // Move to the newly created table
                }
            }

            // Last level, add the property here
            string finalKey = tomlKeys.Last();

            // Handle the case where the value is a Hashtable (convert it to TomlTable recursively)
            if (propertyValue is Hashtable hashtable)
            {
                var convertedTomlTable = HashtableToTomlTable(hashtable);
                currentTable.Remove(finalKey);
                currentTable.Add(finalKey, convertedTomlTable);  // Add the converted TomlTable
            }
            else
            {
                currentTable.Remove(finalKey);
                // Add the property directly if it is not a Hashtable
                currentTable.Add(finalKey, propertyValue);
            }
        }

        public void RemoveProperty(string propertyName)
        {
            // Handle property names that contain dots, indicating nested tables
            if (propertyName.Contains('.'))
            {
                var keys = propertyName.Split('.');

                // Get the deepest nested TomlTable
                TomlTable currentTable = _tomlObject;
                for (int i = 0; i < keys.Length - 1; i++)
                {
                    if (currentTable[keys[i]] is TomlTable nestedTable)
                    {
                        currentTable = nestedTable;
                    }
                    else
                    {
                        throw new Exception($"Property '{keys[i]}' is not a TomlTable or does not exist.");
                    }
                }

                // Remove the property from the deepest nested table
                if (currentTable.ContainsKey(keys[^1]))
                {
                    currentTable.Remove(keys[^1]);
                }
                else
                {
                    throw new Exception($"Property '{keys[^1]}' not found in the TOML table.");
                }
            }
            else
            {
                // Remove the property from the root table if no nesting
                if (_tomlObject.ContainsKey(propertyName))
                {
                    _tomlObject.Remove(propertyName);
                }
                else
                {
                    throw new Exception($"Property '{propertyName}' not found in the TOML table.");
                }
            }
        }

        // Helper method to recursively convert a PowerShell Hashtable to TomlTable
        private static TomlTable HashtableToTomlTable(Hashtable hashtable)
        {
            var tomlTable = new TomlTable(true);  // Create a new TomlTable
            foreach (DictionaryEntry entry in hashtable)
            {
                string key = entry.Key.ToString();

                if (entry.Value is Hashtable nestedHashtable)
                {
                    // Recursively convert nested hashtables
                    tomlTable.Add(key, HashtableToTomlTable(nestedHashtable));
                }
                else
                {
                    // Add simple values directly
                    tomlTable.Add(key, entry.Value);
                }
            }
            return tomlTable;
        }

        private static Hashtable TomlTableToHashtable(TomlTable table){
            var Hashtable = new Hashtable();

            foreach (var key in table.Keys){
                var value = table[key];
                if (value is TomlTable nestedTable){
                    // Recursively convert nested TomlTables
                    Hashtable.Add(key, TomlTableToHashtable(nestedTable));
                }else{
                    // Add simple values directly
                    Hashtable.Add(key, value);
                }
            }
            return Hashtable;
        }

        public Hashtable GetHashTable() {
            return TomlTableToHashtable(_tomlObject);
        }
    }
}