CLS
. PSUnit.ps1

Function Test.GetEnumerator_ReturnsHelp_IfItIsUsedWithGet-HelpCmdlet([switch] $Category_Help)
{
    #Arrange
    #Act
    $Actual = Get-Help "Get-Enumerator" -Full | Out-String
    
    #Assert
    Write-Debug $($Actual.GetType().FullName)
    Assert-That -ActualValue $Actual -Constraint {$ActualValue.Length -gt 0}
}

Function Test.GetEnumerator_TeamIsHashtable([switch] $Category_HashTable)
{   #Arrange
    #Act
    $Team = @{4 = "Joe"; 2 = "Steve"; 12 = "Tom"}
    
    #Assert
    Assert-That -ActualValue $Team -Constraint {$ActualValue -is "System.collections.HashTable"}
}

Function Test.GetEnumerator_Sort-ObjectOnTeamReturnsAHashtable([switch] $Category_HashTable)
{
    #Arrange
    $Team = @{4 = "Joe"; 2 = "Steve"; 12 = "Tom"}
    $Actual = $Team | Sort-Object
    Write-Debug $($Actual.GetType().FullName)
    Assert-That -ActualValue $Actual -Constraint {$ActualValue -is "System.collections.HashTable"}
}

Function Test.GetEnumerator_OnTeamReturnsAnArrayOfDictionaryEntries([switch] $Category_HashTable)
{
    #Arrange
    $Team = @{4 = "Joe"; 2 = "Steve"; 12 = "Tom"}
    
    #Act
    $Actual = $Team | Get-Enumerator
    
    #Assert
    Write-Debug $($Actual.GetType().FullName)
    Assert-That -ActualValue $Actual -Constraint {$ActualValue[0] -is "System.Collections.DictionaryEntry"}
}

Function Test.GetEnumerator_CallingGetEnumeratorFunctionAndSortObjectOnKeyReturnsSortedObjects([switch] $Category_HashTable)
{
    #Arrange
    $Team = @{4 = "Joe"; 2 = "Steve"; 12 = "Tom"}
    
    #Act
    $Actual = $Team.GetEnumerator() | Sort-Object -Property "Key" | Foreach-Object{ $_.key}
    
    #Assert
    Write-Debug $($Actual.GetType().FullName)
    $ExpectedOrder = 2,4,12
    Assert-That -ActualValue $Actual -Constraint {(Compare-Object -ReferenceObject $ExpectedOrder -DifferenceObject $ActualValue -IncludeEqual -SyncWindow 0).Count -eq 3}
}

Function Test.GetEnumerator_SortObjectOnKeyReturnsSortedObjects([switch] $Category_HashTable)
{
    #Arrange
    $Team = @{4 = "Joe"; 2 = "Steve"; 12 = "Tom"}
    
    #Act
    $Actual = $Team | Get-Enumerator | Sort-Object -Property "Key" | Foreach-Object{ $_.key}
    
    #Assert
    Write-Debug $($Actual.GetType().FullName)
    $ExpectedOrder = 2,4,12
    Assert-That -ActualValue $Actual -Constraint {(Compare-Object -ReferenceObject $ExpectedOrder -DifferenceObject $ActualValue -IncludeEqual -SyncWindow 0).Count -eq 3}
}

Function Test.GetEnumerator_UsingAliasEAndSOOnKeyReturnsSortedObjects([switch] $Category_HashTable)
{
    #Arrange
    $Team = @{4 = "Joe"; 2 = "Steve"; 12 = "Tom"}
    
    #Act
    $Actual = $Team |e| so Key | Foreach-Object{ $_.key}
    
    #Assert
    Write-Debug $($Actual.GetType().FullName)
    $ExpectedOrder = 2,4,12
    Assert-That -ActualValue $Actual -Constraint {(Compare-Object -ReferenceObject $ExpectedOrder -DifferenceObject $ActualValue -IncludeEqual -SyncWindow 0).Count -eq 3}
}

Function Test.GetEnumerator_UsingForceSwitchWithHashTableDoesntChangeOutcome([switch] $Category_HashTable)
{
    #Arrange
    $Team = @{4 = "Joe"; 2 = "Steve"; 12 = "Tom"}
    
    #Act
    $Actual = $Team | Get-Enumerator -Force | Sort-Object -Property "Key" | Foreach-Object{ $_.key}
    
    #Assert
    Write-Debug $($Actual.GetType().FullName)
    $ExpectedOrder = 2,4,12
    Assert-That -ActualValue $Actual -Constraint {(Compare-Object -ReferenceObject $ExpectedOrder -DifferenceObject $ActualValue -IncludeEqual -SyncWindow 0).Count -eq 3}
}

Function Test.GetEnumerator_UsingForceSwitchWithHashTableInAliasNotationDoesntChangeOutcome([switch] $Category_HashTable)
{   
    #Arrange
    $Team = @{4 = "Joe"; 2 = "Steve"; 12 = "Tom"}
    
    #Act
    $Actual = $Team |e -f| so Key | Foreach-Object{ $_.key}
    
    #Assert
    Write-Debug $($Actual.GetType().FullName)
    $ExpectedOrder = 2,4,12
    Assert-That -ActualValue $Actual -Constraint {(Compare-Object -ReferenceObject $ExpectedOrder -DifferenceObject $ActualValue -IncludeEqual -SyncWindow 0).Count -eq 3}
}

Function Test.GetEnumerator_UsingForceSwitchAndStrictSwitchWithHashTableDoesntChangeOutcome([switch] $Category_HashTable)
{
    #Arrange
    $Team = @{4 = "Joe"; 2 = "Steve"; 12 = "Tom"}
    
    #Act
    $Actual = $Team | Get-Enumerator -Force -Strict | Sort-Object -Property "Key"| Foreach-Object{ $_.key}
    
    #Assert
    Write-Debug $($Actual.GetType().FullName)
    $ExpectedOrder = 2,4,12
    Assert-That -ActualValue $Actual -Constraint {(Compare-Object -ReferenceObject $ExpectedOrder -DifferenceObject $ActualValue -IncludeEqual -SyncWindow 0).Count -eq 3}
}

Function Test.GetEnumerator_UsingForceSwitchAndStrictSwitchInAliasNotationWithHashTableDoesntChangeOutcome([switch] $Category_HashTable)
{
    #Arrange
    $Team = @{4 = "Joe"; 2 = "Steve"; 12 = "Tom"}
    
    #Act
    $Actual = $Team |e -f -s| so Key| Foreach-Object{ $_.key}
    
    #Assert
    Write-Debug $($Actual.GetType().FullName)
    $ExpectedOrder = 2,4,12
    Assert-That -ActualValue $Actual -Constraint {(Compare-Object -ReferenceObject $ExpectedOrder -DifferenceObject $ActualValue -IncludeEqual -SyncWindow 0).Count -eq 3}
}

Function Test.GetEnumerator_UsingStrictSwitchAndForceSwitchWithArrayInAliasNotationThrowsRuntimeException([switch] $Category_Array, [System.Management.Automation.RuntimeException] $ExpectedException = $(New-Object -TypeName "System.Management.Automation.RuntimeException"))
{
    #Arrange
    $RosterNumbers = 4,2,12
    
    #Act
    $Actual = $RosterNumbers |e -f -s| so
    
    #Assert
}

Function Test.GetEnumerator_NotUsingForceSwitchWithStringArrayInAliasNotationThrowsRuntimeException([switch] $Category_Array, [System.Management.Automation.RuntimeException] $ExpectedException = $(New-Object -TypeName "System.Management.Automation.RuntimeException"))
{
    #Arrange
    $RosterNames = "Joe", "Steve", "Tom"
    
    #Act
    $Actual = $RosterNames |e| so
    
    #Assert
}

Function Test.GetEnumerator_NotUsingForceSwitchWithIntegerArrayInAliasNotationThrowsRuntimeException([switch] $Category_Array, [System.Management.Automation.RuntimeException] $ExpectedException = $(New-Object -TypeName "System.Management.Automation.RuntimeException"))
{
    #Arrange
    $RosterNumbers = 4,2,12
    $Actual = $RosterNumbers |e| so 
}

Function Test.GetEnumerator_UsingForceSwitchWithArrayOfIntegersReturnsSortedArrayOfIntegers([switch] $Category_Array)
{
    #Arrange
    $RosterNumbers = 4,2,12
    
    #Act
    $Actual = $RosterNumbers | Get-Enumerator -Force | Sort-Object
    
    #Assert
    Write-Debug $($Actual.GetType().FullName)
    $ExpectedOrder = 2,4,12
    Assert-That -ActualValue $Actual -Constraint {(Compare-Object -ReferenceObject $ExpectedOrder -DifferenceObject $ActualValue -IncludeEqual -SyncWindow 0).Count -eq 3}
}

Function Test.GetEnumerator_UsingForceSwitchInAliasNotationWithArrayOfIntegersReturnsSortedArrayOfIntegers([switch] $Category_Array)
{
    #Arrange
    $RosterNumbers = 4,2,12
    
    #Act
    $Actual = $RosterNumbers | e -f | so
    
    #Assert
    Write-Debug $($Actual.GetType().FullName)
    $ExpectedOrder = 2,4,12
    Assert-That -ActualValue $Actual -Constraint {(Compare-Object -ReferenceObject $ExpectedOrder -DifferenceObject $ActualValue -IncludeEqual -SyncWindow 0).Count -eq 3}
}

Function Test.GetEnumerator_UsingForceSwitchWithArrayOfStringsReturnsSortedArrayOfCharacters([switch] $Category_Array)
{
    #Arrange
    $RosterNames = "Joe", "Steve", "Tom"
    
    #Act
    $Actual = $RosterNames | Get-Enumerator -Force | Sort-Object
    
    #Assert
    Write-Debug $($Actual.GetType().FullName)
    $ExpectedOrder = 'J', 'S', 'T', 'e', 'e', 'e', 'm', 'o', 'o', 't', 'v'
    Assert-That -ActualValue $Actual -Constraint {(Compare-Object -ReferenceObject $ExpectedOrder -DifferenceObject $ActualValue -IncludeEqual -SyncWindow 0).Count -eq 11}
}

Function Test.GetEnumerator_UsingForceSwitchInAliasNotationWithArrayOfStringsReturnsSortedArrayOfCharacters([switch] $Category_Array)
{
    #Arrange
    $RosterNames = "Joe", "Steve", "Tom"
    
    #Act
    $Actual = $RosterNames | e -f | so
    
    #Assert
    Write-Debug $($Actual.GetType().FullName)
    $ExpectedOrder = 'J', 'S', 'T', 'e', 'e', 'e', 'm', 'o', 'o', 't', 'v'
    Assert-That -ActualValue $Actual -Constraint {(Compare-Object -ReferenceObject $ExpectedOrder -DifferenceObject $ActualValue -IncludeEqual -SyncWindow 0).Count -eq 11}
}

Function Test.GetEnumerator_UsingForceSwitchAndPreserveStringSwitchWithArrayOfStringsReturnsSortedArrayOfStrings([switch] $Category_Array)
{
    #Arrange
    $RosterNames = "Joe", "Steve", "Tom"
    
    #Act
    $Actual = $RosterNames | Get-Enumerator -Force -PreserveString | Sort-Object
    
    #Assert
    Write-Debug $($Actual.GetType().FullName)
    $ExpectedOrder = "Joe", "Steve", "Tom"
    Assert-That -ActualValue $Actual -Constraint {(Compare-Object -ReferenceObject $ExpectedOrder -DifferenceObject $ActualValue -IncludeEqual -SyncWindow 0).Count -eq 3}
}

Function Test.GetEnumerator_UsingForceSwitchAndPreserveStringSwitchAndStrictSwitchWithArrayOfStringsReturnsSortedArrayOfStrings([switch] $Category_Array)
{
    #Arrange
    $RosterNames = "Joe", "Steve", "Tom"
    
    #Act
    $Actual = $RosterNames | Get-Enumerator -Force -PreserveString -Strict | Sort-Object
    
    #Assert
    Write-Debug $($Actual.GetType().FullName)
    $ExpectedOrder = "Joe", "Steve", "Tom"
    Assert-That -ActualValue $Actual -Constraint {(Compare-Object -ReferenceObject $ExpectedOrder -DifferenceObject $ActualValue -IncludeEqual -SyncWindow 0).Count -eq 3}
}


Function Test.GetEnumerator_UsingForceSwitchAndPreserveStringSwitchInAliasNotationWithArrayOfStringsReturnsSortedArrayOfStrings([switch] $Category_Array)
{
    #Arrange
    $RosterNames = "Joe", "Steve", "Tom"
    
    #Act
    $Actual = $RosterNames | e -f -p | so
    
    #Assert
    Write-Debug $($Actual.GetType().FullName)
    $ExpectedOrder = "Joe", "Steve", "Tom"
    Assert-That -ActualValue $Actual -Constraint {(Compare-Object -ReferenceObject $ExpectedOrder -DifferenceObject $ActualValue -IncludeEqual -SyncWindow 0).Count -eq 3}
}

Function Test.GetEnumerator_UsingForceSwitchAndPreserveStringSwitchAndStrictSwitchInAliasNotationWithArrayOfStringsReturnsSortedArrayOfStrings([switch] $Category_Array)
{
    #Arrange
    $RosterNames = "Joe", "Steve", "Tom"
    
    #Act
    $Actual = $RosterNames | e -f -p -s| so
    
    #Assert
    Write-Debug $($Actual.GetType().FullName)
    $ExpectedOrder = "Joe", "Steve", "Tom"
    Assert-That -ActualValue $Actual -Constraint {(Compare-Object -ReferenceObject $ExpectedOrder -DifferenceObject $ActualValue -IncludeEqual -SyncWindow 0).Count -eq 3}
}


Function Test.GetEnumerator_UsingForceSwitchWithArrayListOfIntegersInAliasNotationReturnsSortedArrayOfIntegers([switch] $Category_ArrayList)
{
    #Arrange
    $RosterNumbers = 4,2,12
    $RosterNumberList = New-Object -TypeName "System.Collections.ArrayList"
    $RosterNumbers | foreach-object {$RosterNumberList.Add($_)} | Out-Null
    
    #Act
    $Actual = $RosterNumberList |e -f| so
    
    #Assert
    Write-Debug $($Actual.GetType().FullName)
    $ExpectedOrder = 2,4,12
    Assert-That -ActualValue $Actual -Constraint {(Compare-Object -ReferenceObject $ExpectedOrder -DifferenceObject $ActualValue -IncludeEqual -SyncWindow 0).Count -eq 3}
}

Function Test.GetEnumerator_NotUsingForceSwitchAndStrictSwitchWithArrayListOfIntegersInAliasNotationThrowsRuntimeException([switch] $Category_ArrayList, [System.Management.Automation.RuntimeException] $ExpectedException = $(New-Object -TypeName "System.Management.Automation.RuntimeException"))
{
    #Arrange
    $RosterNumbers = 4,2,12
    $RosterNumberList = New-Object -TypeName "System.Collections.ArrayList"
    $RosterNumbers | foreach-object {$RosterNumberList.Add($_)} | Out-Null
    
    #Act
    $Actual = $RosterNumberList |e -f -s| so #ArrayList gets implicitly converted to an array (ToArray()) and treated as such
    
    #Assert
}

Function Test.GetEnumerator_NotUsingForceSwitchWithArrayListOfIntegersInAliasNotationThrowsRuntimeException([switch] $Category_ArrayList, [System.Management.Automation.RuntimeException] $ExpectedException = $(New-Object -TypeName "System.Management.Automation.RuntimeException"))
{
    #Arrange
    $RosterNumbers = 4,2,12
    $RosterNumberList = New-Object -TypeName "System.Collections.ArrayList"
    $RosterNumbers | foreach-object {$RosterNumberList.Add($_)} | Out-Null
    
    #Act
    $Actual = $RosterNumberList |e | so
    
    #Assert
}

Function Test.GetEnumerator_NotUsingForceSwitchWithArrayListOfStringsInAliasNotationThrowsRuntimeException([switch] $Category_ArrayList, [System.Management.Automation.RuntimeException] $ExpectedException = $(New-Object -TypeName "System.Management.Automation.RuntimeException"))
{
    #Arrange
    $RosterNames = "Joe", "Steve", "Tom"
    $RosterNameList = New-Object -TypeName "System.Collections.ArrayList"
    $RosterNames | foreach-object {$RosterNameList.Add($_)} | Out-Null
    
    #Act
    $Actual = $RosterNameList |e | so
    
    #Assert
}



Function Test.GetEnumerator_UsingForceSwitchWithArrayListOfIntegersReturnsSortedArrayOfIntegers([switch] $Category_ArrayList)
{
    #Arrange
    $RosterNumbers = 4,2,12
    $RosterNumberList = New-Object -TypeName "System.Collections.ArrayList"
    $RosterNumbers | foreach-object {$RosterNumberList.Add($_)} | Out-Null
    
    #Act
    $Actual = $RosterNumberList | Get-Enumerator -Force | Sort-Object
    
    #Assert
    Write-Debug $($Actual.GetType().FullName)
    $ExpectedOrder = 2,4,12
    Assert-That -ActualValue $Actual -Constraint {(Compare-Object -ReferenceObject $ExpectedOrder -DifferenceObject $ActualValue -IncludeEqual -SyncWindow 0).Count -eq 3}
}

Function Test.GetEnumerator_UsingForceSwitchWithArrayListOfStringsReturnsSortedArrayOfCharacters([switch] $Category_ArrayList)
{
    #Arrange
    $RosterNames = "Joe", "Steve", "Tom"
    $RosterNameList = New-Object -TypeName "System.Collections.ArrayList"
    $RosterNames | foreach-object {$RosterNameList.Add($_)} | Out-Null
    
    #Act
    $Actual = $RosterNameList | Get-Enumerator -Force | Sort-Object
    
    #Assert
    Write-Debug $($Actual.GetType().FullName)
    $ExpectedOrder = 'J', 'S', 'T', 'e', 'e', 'e', 'm', 'o', 'o', 't', 'v'
    Assert-That -ActualValue $Actual -Constraint {(Compare-Object -ReferenceObject $ExpectedOrder -DifferenceObject $ActualValue -IncludeEqual -SyncWindow 0).Count -eq 11}
}

Function Test.GetEnumerator_UsingForceSwitchWithArrayListOfStringsInAliasNotationReturnsSortedArrayOfCharacters([switch] $Category_ArrayList)
{
    #Arrange
    $RosterNames = "Joe", "Steve", "Tom"
    $RosterNameList = New-Object -TypeName "System.Collections.ArrayList"
    $RosterNames | foreach-object {$RosterNameList.Add($_)} | Out-Null
    
    #Act
    $Actual = $RosterNameList | e -f | so
    
    #Assert
    Write-Debug $($Actual.GetType().FullName)
    $ExpectedOrder = 'J', 'S', 'T', 'e', 'e', 'e', 'm', 'o', 'o', 't', 'v'
    Assert-That -ActualValue $Actual -Constraint {(Compare-Object -ReferenceObject $ExpectedOrder -DifferenceObject $ActualValue -IncludeEqual -SyncWindow 0).Count -eq 11}
}

Function Test.GetEnumerator_UsingForceSwitchAndPreserveStringSwitchWithArrayListOfStringsReturnsSortedArrayOfStrings([switch] $Category_ArrayList)
{
    #Arrange
    $RosterNames = "Joe", "Steve", "Tom"
    $RosterNameList = New-Object -TypeName "System.Collections.ArrayList"
    $RosterNames | foreach-object {$RosterNameList.Add($_)} | Out-Null
    
    #Act
    $Actual = $RosterNameList | e -Force -PreserveString| so
    
    #Assert
    Write-Debug $($Actual.GetType().FullName)
    $ExpectedOrder = "Joe", "Steve", "Tom"
    Assert-That -ActualValue $Actual -Constraint {(Compare-Object -ReferenceObject $ExpectedOrder -DifferenceObject $ActualValue -IncludeEqual -SyncWindow 0).Count -eq 3}
}

Function Test.GetEnumerator_UsingForceSwitchAndPreserveStringSwitchWithArrayListOfStringsInAliasNotationReturnsSortedArrayOfStrings([switch] $Category_ArrayList)
{
    #Arrange
    $RosterNames = "Joe", "Steve", "Tom"
    $RosterNameList = New-Object -TypeName "System.Collections.ArrayList"
    $RosterNames | foreach-object {$RosterNameList.Add($_)} | Out-Null
    
    #Act
    $Actual = $RosterNameList | e -f -p | so

    #Assert
    Write-Debug $($Actual.GetType().FullName)
    $ExpectedOrder = "Joe", "Steve", "Tom"
    Assert-That -ActualValue $Actual -Constraint {(Compare-Object -ReferenceObject $ExpectedOrder -DifferenceObject $ActualValue -IncludeEqual -SyncWindow 0).Count -eq 3}
}

Function Test.GetEnumerator_UsingForceSwitchAndPreserveStringSwitchAndStrictSwitchWithArrayListOfStringsInAliasNotationReturnsSortedArrayOfStrings([switch] $Category_ArrayList)
{
    #Arrange
    $RosterNames = "Joe", "Steve", "Tom"
    $RosterNameList = New-Object -TypeName "System.Collections.ArrayList"
    $RosterNames | foreach-object {$RosterNameList.Add($_)} | Out-Null
    
    #Act
    $Actual = $RosterNameList | e -f -p -s| so

    #Assert
    Write-Debug $($Actual.GetType().FullName)
    $ExpectedOrder = "Joe", "Steve", "Tom"
    Assert-That -ActualValue $Actual -Constraint {(Compare-Object -ReferenceObject $ExpectedOrder -DifferenceObject $ActualValue -IncludeEqual -SyncWindow 0).Count -eq 3}
}

Function Test.GetEnumerator_UsingForceSwitchAndPreserveStringSwitchAndStrictSwitchWithArrayListOfStringsReturnsSortedArrayOfStrings([switch] $Category_ArrayList)
{
    #Arrange
    $RosterNames = "Joe", "Steve", "Tom"
    $RosterNameList = New-Object -TypeName "System.Collections.ArrayList"
    $RosterNames | foreach-object {$RosterNameList.Add($_)} | Out-Null
    
    #Act
    $Actual = $RosterNameList | e -Force -PreserveString -Strict| so

    #Assert
    Write-Debug $($Actual.GetType().FullName)
    $ExpectedOrder = "Joe", "Steve", "Tom"
    Assert-That -ActualValue $Actual -Constraint {(Compare-Object -ReferenceObject $ExpectedOrder -DifferenceObject $ActualValue -IncludeEqual -SyncWindow 0).Count -eq 3}
}

Function Test.GetEnumerator_UsingForceSwitchWithSortedListOfIntegersReturnsSortedListOfIntegers([switch] $Category_SortedList)
{
    #Arrange
    $RosterNumbers = 4,2,12
    $RosterNumberList = New-Object -TypeName "System.Collections.SortedList"
    $RosterNumbers | foreach-object {$RosterNumberList.Add($_, $_)} | Out-Null
    
    #Act
    $Actual = $RosterNumberList |e -f| %{$_.Value}

    #Assert
    Write-Debug $($Actual.GetType().FullName)
    $ExpectedOrder = 2,4,12
    Assert-That -ActualValue $Actual -Constraint {(Compare-Object -ReferenceObject $ExpectedOrder -DifferenceObject $ActualValue -IncludeEqual -SyncWindow 0).Count -eq 3}
}

Function Test.GetEnumerator_UsingForceSwitchAndStrictSwitchWithSortedListOfIntegersReturnsSortedListOfIntegers([switch] $Category_SortedList)
{
    #Arrange
    $RosterNumbers = 4,2,12
    $RosterNumberList = New-Object -TypeName "System.Collections.SortedList"
    $RosterNumbers | foreach-object {$RosterNumberList.Add($_, $_)} | Out-Null
    
    #Act
    $Actual = $RosterNumberList |e -f -s| %{$_.Value}

    #Assert
    Write-Debug $($Actual.GetType().FullName)
    $ExpectedOrder = 2,4,12
    Assert-That -ActualValue $Actual -Constraint {(Compare-Object -ReferenceObject $ExpectedOrder -DifferenceObject $ActualValue -IncludeEqual -SyncWindow 0).Count -eq 3}
}

Function Test.GetEnumerator_NotUsingForceSwitchWithSortedListOfIntegersInAliasNotationThrowsRuntimeException([switch] $Category_SortedList, [System.Management.Automation.RuntimeException] $ExpectedException = $(New-Object -TypeName "System.Management.Automation.RuntimeException"))
{
    #Arrange
    $RosterNumbers = 4,2,12
    $RosterNumberList = New-Object -TypeName "System.Collections.SortedList"
    $RosterNumbers | foreach-object {$RosterNumberList.Add($_, $_)} | Out-Null
    
    #Act
    $Actual = $RosterNumberList |e| %{$_.Value}
    
    #Assert

}

Function Test.GetEnumerator_NotUsingForceSwitchWithSortedListOfStringsInAliasNotationThrowsRuntimeException([switch] $Category_SortedList, [System.Management.Automation.RuntimeException] $ExpectedException = $(New-Object -TypeName "System.Management.Automation.RuntimeException"))
{
    #Arrange
    $RosterNames = "Joe", "Steve", "Tom"
    $RosterNameList = New-Object -TypeName "System.Collections.SortedList"
    $RosterNames | foreach-object {$RosterNameList.Add($_, $_)} | Out-Null
    
    #Act
    $Actual = $RosterNameList |e| %{$_.Value}
    
    #Assert
}

Function Test.GetEnumerator_UsingForceSwitchWithSortedListOfStringsReturnsSortedListOfStrings([switch] $Category_SortedList)
{
    #Arrange
    $RosterNames = "Joe", "Steve", "Tom"
    $RosterNameList = New-Object -TypeName "System.Collections.SortedList"
    $RosterNames | foreach-object {$RosterNameList.Add($_, $_)} | Out-Null
    
    #Act
    $Actual = $RosterNameList | e -f | %{$_.Value}
    
    #Assert
    Write-Debug $($Actual.GetType().FullName)
    $ExpectedOrder = "Joe", "Steve", "Tom"
    Assert-That -ActualValue $Actual -Constraint {(Compare-Object -ReferenceObject $ExpectedOrder -DifferenceObject $ActualValue -IncludeEqual -syncwindow 0).Count -eq 3}
}

Function Test.GetEnumerator_UsingForceSwitchAndStrictSwitchWithSortedListOfStringsInAliasNotationReturnsSortedListOfStrings([switch] $Category_SortedList)
{
    #Arrange
    $RosterNames = "Joe", "Steve", "Tom"
    $RosterNameList = New-Object -TypeName "System.Collections.SortedList"
    $RosterNames | foreach-object {$RosterNameList.Add($_, $_)} | Out-Null
    
    #Act
    $Actual = $RosterNameList | e -f -s | %{$_.Value}
    
    #Assert
    Write-Debug $($Actual.GetType().FullName)
    $ExpectedOrder = "Joe", "Steve", "Tom"
    Assert-That -ActualValue $Actual -Constraint {(Compare-Object -ReferenceObject $ExpectedOrder -DifferenceObject $ActualValue -IncludeEqual -syncwindow 0).Count -eq 3}
}

Function Test.GetEnumerator_UsingForceSwitchAndPreserveStringSwitchWithSortedListOfStringsReturnsSortedListOfStrings([switch] $Category_SortedList)
{
    #Arrange
    $RosterNames = "Joe", "Steve", "Tom"
    $RosterNameList = New-Object -TypeName "System.Collections.SortedList"
    $RosterNames | foreach-object {$RosterNameList.Add($_, $_)} | Out-Null
    
    #Act
    $Actual = $RosterNameList | e -Force -PreserveString| %{$_.Value}
    
    #Assert
    Write-Debug $($Actual.GetType().FullName)
    $ExpectedOrder = "Joe", "Steve", "Tom"
    Assert-That -ActualValue $Actual -Constraint {(Compare-Object -ReferenceObject $ExpectedOrder -DifferenceObject $ActualValue -IncludeEqual -syncwindow 0).Count -eq 3}
}

Function Test.GetEnumerator_UsingForceSwitchAndPreserveStringSwitchAndStrictSwitchWithSortedListOfStringsReturnsSortedListOfStrings([switch] $Category_SortedList)
{
    #Arrange
    $RosterNames = "Joe", "Steve", "Tom"
    $RosterNameList = New-Object -TypeName "System.Collections.SortedList"
    $RosterNames | foreach-object {$RosterNameList.Add($_, $_)} | Out-Null
    
    #Act
    $Actual = $RosterNameList | e -Force -PreserveString -Strict| %{$_.Value}
    
    #Assert
    Write-Debug $($Actual.GetType().FullName)
    $ExpectedOrder = "Joe", "Steve", "Tom"
    Assert-That -ActualValue $Actual -Constraint {(Compare-Object -ReferenceObject $ExpectedOrder -DifferenceObject $ActualValue -IncludeEqual -syncwindow 0).Count -eq 3}
}

Function Test.GetEnumerator_UsingForceSwitchAndPreserveStringSwitchWithSortedListOfStringsInAliasNotationReturnsSortedListOfStrings([switch] $Category_SortedList)
{
    #Arrange
    $RosterNames = "Joe", "Steve", "Tom"
    $RosterNameList = New-Object -TypeName "System.Collections.SortedList"
    $RosterNames | foreach-object {$RosterNameList.Add($_, $_)} | Out-Null
    
    #Act
    $Actual = $RosterNameList | e -f -p | %{$_.Value}
    
    #Assert
    Write-Debug $($Actual.GetType().FullName)
    $ExpectedOrder = "Joe", "Steve", "Tom"
    Assert-That -ActualValue $Actual -Constraint {(Compare-Object -ReferenceObject $ExpectedOrder -DifferenceObject $ActualValue -IncludeEqual -syncwindow 0).Count -eq 3}
}

Function Test.GetEnumerator_UsingForceSwitchAndPreserveStringSwitchAndStrictSwitchWithSortedListOfStringsInAliasNotationReturnsSortedListOfStrings([switch] $Category_SortedList)
{
    #Arrange
    $RosterNames = "Joe", "Steve", "Tom"
    $RosterNameList = New-Object -TypeName "System.Collections.SortedList"
    $RosterNames | foreach-object {$RosterNameList.Add($_, $_)} | Out-Null
    
    #Act
    $Actual = $RosterNameList | e -f -p -s| %{$_.Value}
    
    #Assert
    Write-Debug $($Actual.GetType().FullName)
    $ExpectedOrder = "Joe", "Steve", "Tom"
    Assert-That -ActualValue $Actual -Constraint {(Compare-Object -ReferenceObject $ExpectedOrder -DifferenceObject $ActualValue -IncludeEqual -syncwindow 0).Count -eq 3}
}
