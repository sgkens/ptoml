using namespace Ptoml;
using namespace tomlyn;

#dotnet publish -c release -r win-x64 -o lib

add-Type -Path .\lib\ptoml\release\net8.0\win-x64\publish\tomlyn.dll
add-Type -Path .\lib\ptoml\release\net8.0\win-x64\publish\ptoml.dll


# toml string to create, tofadd, tofrm, tof
$tomlString = get-content -raw -path .\ptoml-new.toml

# initialize parser
$tomlTable = new-object -typename 'ptoml.tomlParser'

# Parse takes raw toml string and load into memory
$tomlTable.FromToml($tomlString)

$tomlTable.gethashtable($tomlTable.FromToml($tomlString))

# Get-Property not nested in root path
return  
break;
# Add a property to the toml object 
# supports 
# - strings, bools, hashtables, arrays int, nested hashtables, etc.
# !Note parses implicit [System.Collections.Hashtable] objects 
# !     Must me @{} or [hashtable] object [array]@() objects
$tomlTable.AddProperty(
    'servermembers', @{  
        properties = @{
            MyColor='blue'
            members = @{member1=1;members2=2;members3=3}
            config_files=@('file1','file2')
            servers=@('servmj2','servmj3','servmj4')
            config_active = $true
        }
    }
)

#$tomlTable.UpdateProperty('servermembers.properties.members', @{member1 = 'NewValue'; member2 = 'NewVAlue' })

#$tomlTable.RemoveProperty('servermembers.properties.config_files')

# returns toml in string form
#$tomlparser.ToTomlString() 

# returns <TomlTable> object witch is 
# [System.Collections.Generic.Dictionary<KeyValuePair<string,Object>>>]
#$tomlparser.ToTomlTable() 

# Extract a Property and access it  you can use $tomlparser.ToTomlTable() to access the toml object and do the same thing
#$tomlparser.removeproperty('ServerMembers')
#$tomlparser.ExtractProperty('ServerMembers')['ServerMembers']['properties']['servers']
#$tomlTable.ToToml()
#return $tomlTable.ToTomlTable()['servermembers']['properties']
return $tomlTable.GetProperty('servermembers.properties') #['config_files'] # returns Null, could change to through exception if needed

#[tomlparser]::ONToKeyPairString('mapper.values.myconfig.map')

break;

# Update some properties
# $tomlparser.AddProperty("ServerMembers.branch1", @{members=@()})
# $tomlparser.AddProperty("ServerSessions.branch1", @{sessions}) })
# $tomlparser.ToTomlString()
#$toml

# $tomlJson = $toml | convertto-json -depth 10
#$tomlJson

# to json and back again
# $tomlBackfromJson = $tomlJson | convertfrom-json -depth 10
#$tomlBackfromJson

# $temp_object = new-object -typename 'system.collections.generic.Dictionary[[string],[object]]'
# foreach($item in $tomlBackfromJson.psobject.properties.where({$_.memberType -eq 'noteproperty'}))
# {
#     $temp_object.add($item.Name, $item.Value)
# }
# $temp_object


[TomlParser]::TomlTable($temp_object)

#[TomlParser]::StringifyToml($temp_object)

# cast to hashtable make it easy to interect with coforge
#$tomlCast = [TomlParser]::CastToHashTable($toml)
#$tomlCast

# # cast tomlTable Back to string
# $tomlString = [TomlParser]::StringifyToml($tomlString)
# $tomlString

