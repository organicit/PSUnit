. PSUnit.ps1                                        #Load PSUnit frame work (Accessible via PATH environment variable set in the profile)

#Assertions +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
#Equality Asserts =============================================================
#Assert.AreEqual( int expected, int actual );

function Test.Assert.AreEqual()
{
    #Arrange
    [int] $Num1 = 2;
    [int] $Num2 = 2;
    
    #Act
    $Result = $Num1 + $Num2
    
    #Assert
    Assert-That -ActualValue $Result -Constraint {$ActualValue -eq 4}
}

#Assert.AreNotEqual( int expected, int actual );
function Test.Assert.AreNotEqual()
{
    #Arrange
    [int] $Num1 = 2;
    [int] $Num2 = 2;
    
    #Act
    $Result = $Num1 + $Num2
    
    #Assert
    Assert-That -ActualValue $Result -Constraint {$ActualValue -ne 5}
}

#Special Cases
#Assert.AreEqual( double.PositiveInfinity, double.PositiveInfinity );
function Test.Assert.AreEqualPositiveInfinity()
{
    #Arrange
    [Double] $Num1 = [Double]::PositiveInfinity;
    
    #Act
    $Result = $Num1
    
    #Assert
    Assert-That -ActualValue $Result -Constraint {$ActualValue -eq [Double]::PositiveInfinity}
}

#Assert.AreEqual( double.NegativeInfinity, double.NegativeInfinity );
function Test.Assert.AreEqualNegativeInfinity()
{
    #Arrange
    [Double] $Num1 = [Double]::NegativeInfinity;
    
    #Act
    $Result = $Num1
    
    #Assert
    Assert-That -ActualValue $Result -Constraint {$ActualValue -eq [Double]::NegativeInfinity}
}

#Assert.AreEqual( double.NaN, double.NaN );
function Test.Assert.AreEqualNaN()
{
    #Arrange
    [Double] $Num1 = [Double]::NaN;
    
    #Act
    $Result = $Num1
    
    #Assert
    Assert-That -ActualValue $Result -Constraint {$ActualValue -eq [Double]::NaN}
}

#Assert.AreEqual( double expected, double actual ); GlobalSettings.DefaultFloatingPointTolerance
function Test.Assert.AreEqualUsingFloatingPointTolerance()
{
    #Arrange
    [Double] $Num1 = 10.00;
    [Double] $Num2 = 3;
    
    [Double] $FloatingPointTolerance = 0.001
    
    #Act
    $Result = $Num1 / $Num2
    
    #Assert
    Assert-That -ActualValue $Result -Constraint {$ActualValue -le (3.333 + $FloatingPointTolerance) -and $ActualValue -ge (3.333 - $FloatingPointTolerance)}
}

#Assert.AreEqual( double expected, double actual ); GlobalSettings.DefaultFloatingPointTolerance
function Test.Assert.AreNotEqualUsingFloatingPointTolerance()
{
    #Arrange
    [Double] $Num1 = 10.00;
    [Double] $Num2 = 3;
    
    [Double] $FloatingPointTolerance = 0.0001
    
    #Act
    $Result = $Num1 / $Num2
    
    #Assert
    Assert-That -ActualValue $Result -Constraint {!($ActualValue -le (3.333 + $FloatingPointTolerance) -and $ActualValue -ge (3.333 - $FloatingPointTolerance))}
}

#Identity Asserts =============================================================

#Assert.AreSame and Assert.AreNotSame test whether the same objects are referenced by the two arguments.
#Assert.AreSame( object expected, object actual );
function Test.Assert.AreSame()
{
    #Arrange
    $Hash1 = @{}
    $Hash1[1] = "one"
    $Hash1[2] = "two"
    
    $Hash3 = @{}
    $Hash3[1] = "one"
    $Hash3[2] = "two"
    
    #Act
    $Hash2 = $Hash1

    #Assert
    Assert-That -ActualValue $Hash2 -Constraint {$ActualValue -eq $Hash1}
    Assert-That -ActualValue $Hash2 -Constraint {$ActualValue -ne $Hash3}
}

#Assert.AreNotSame( object expected, object actual );
function Test.Assert.AreNotSame()
{
    #Arrange
    $Hash1 = @{}
    $Hash1[1] = "one"
    $Hash1[2] = "two"
    
    $Hash3 = @{}
    $Hash3[1] = "one"
    $Hash3[2] = "two"
    
    #Act
    $Hash2 = $Hash1

    #Assert
    Assert-That -ActualValue $Hash1 -Constraint {$ActualValue -ne $Hash3}
}

#Assert.Contains is used to test whether an object is contained in an array or list.
#Assert.Contains( object anObject, IList collection );
function Test.Assert.Contains()
{
    #Arrange
    $Hash = @{}
    $Hash[1] = "one"
    $Hash[2] = "two"
    
    #Act
    $Value = 1

    #Assert
    Assert-That -ActualValue $Value -Constraint {$Hash[$ActualValue] -ne $Null}
}

#Condition Tests ==============================================================
#Assert.IsTrue( bool condition );
function Test.Assert.IsTrue()
{
    #Arrange
    [Bool] $Value = $false
    
    #Act
    $Value = $True

    #Assert
    Assert-That -ActualValue $Value -Constraint {$ActualValue -eq $True}
}

#Assert.IsFalse( bool condition);
function Test.Assert.IsFalse()
{
    #Arrange
    [Bool] $Value = $True
    
    #Act
    $Value = $False

    #Assert
    Assert-That -ActualValue $Value -Constraint {$ActualValue -eq $False}
}

#Assert.IsNull( object anObject ); Need to consider $ActualValue is $Null case
function Test.Assert.IsNull()
{
    #Arrange
    $Value = $Null
    
    #Act
    $Value = $Null

    #Assert
    Assert-That -ActualValue $Value -Constraint {$ActualValue -eq $Null}
}

#Assert.IsNotNull( object anObject );
function Test.Assert.IsNotNull()
{
    #Arrange
    $Value = $Null
    
    #Act
    $Value = "A real value"

    #Assert
    Assert-That -ActualValue $Value -Constraint {$ActualValue -ne $Null}
}

#Assert.IsNaN( double aDouble );
function Test.Assert.IsNaN()
{
    #Arrange
    $Value = $Null
    
    #Act
    $Value = [Double]::NaN

    #Assert
    Assert-That -ActualValue $Value -Constraint {$ActualValue -eq [Double]::NaN}
}

#Assert.IsEmpty( string aString );
function Test.Assert.IsEmptyString()
{
    #Arrange
    $Value = $Null
    
    #Act
    $Value = ""

    #Assert
    Assert-That -ActualValue $Value -Constraint {$ActualValue -eq [String]::Empty}
}

#Assert.IsNotEmpty( string aString );
function Test.Assert.IsNotEmptyString()
{
    #Arrange
    $Value = $Null
    
    #Act
    $Value = "A real value"

    #Assert
    Assert-That -ActualValue $Value -Constraint {$ActualValue -ne [String]::Empty}
}

#Assert.IsEmpty( ICollection collection );
function Test.Assert.IsEmptyCollection()
{
    #Arrange
    $Value = $Null
    
    #Act
    $Value = New-Object -TypeName "System.Collections.ArrayList"
    $Value.Clear()

    #Assert
    Assert-That -ActualValue $Value -Constraint {$ActualValue.Count -eq 0}
}

#Assert.IsNotEmpty( ICollection collection );
function Test.Assert.IsNotEmptyCollection()
{
    #Arrange
    $Value = $Null
    
    #Act
    $Value = New-Object -TypeName "System.Collections.ArrayList"
    $Result = $Value.Add("At least one item")

    #Assert
    Assert-That -ActualValue $Value -Constraint {$ActualValue.Count -ne 0}
}

#Comparisons ==================================================================

#Assert.Greater( int arg1, int arg2 );
#Assert.GreaterOrEqual( int arg1, int arg2 );
#Assert.Less( int arg1, int arg2 );
#Assert.LessOrEqual( int arg1, int arg2 );

#Special cases are DateTime

#Type Asserts =================================================================

#Assert.IsInstanceOfType( Type expected, object actual );			
#Assert.IsNotInstanceOfType( Type expected, object actual );		
#Assert.IsAssignableFrom( Type expected, object actual );				
#Assert.IsNotAssignableFrom( Type expected, object actual );

#Utility Methods ==============================================================

#Assert.Fail()
#Assert.Ignore()

#Exception Assert =============================================================

#Provided with test parameter

#String Asserts

#StringAssert.Contains( string expected, string actual );
#StringAssert.StartsWith( string expected, string actual );
#StringAssert.EndsWith( string expected, string actual );
#StringAssert.AreEqualIgnoringCase( string expected, string actual );				
#StringAssert.IsMatch( string regexPattern, string actual );

#Collection Asserts ===========================================================

#CollectionAssert.AllItemsAreInstancesOfType( IEnumerable collection, Type expectedType );
#CollectionAssert.AllItemsAreNotNull( IEnumerable collection );
#CollectionAssert.AllItemsAreUnique( IEnumerable collection );
#CollectionAssert.AreEqual( IEnumerable expected, IEnumerable actual );
#CollectionAssert.AreEquivalent( IEnumerable expected, IEnumerable actual);
#CollectionAssert.AreNotEqual( IEnumerable expected, IEnumerable actual );
#CollectionAssert.AreNotEquivalent( IEnumerable expected, IEnumerable actual );
#CollectionAssert.Contains( IEnumerable expected, object actual );
#CollectionAssert.DoesNotContain( IEnumerable expected, object actual );
#CollectionAssert.IsSubsetOf( IEnumerable subset, IEnumerable superset );
#CollectionAssert.IsNotSubsetOf( IEnumerable subset, IEnumerable superset);
#CollectionAssert.IsEmpty( IEnumerable collection );
#CollectionAssert.IsNotEmpty( IEnumerable collection );
#CollectionAssert.IsOrdered( IEnumerable collection );
#CollectionAssert.IsOrdered( IEnumerable collection, IComparer comparer );

#File Asserts

#FileAssert.AreEqual( Stream expected, Stream actual );
#FileAssert.AreEqual( FileInfo expected, FileInfo actual );
#FileAssert.AreEqual( string expected, string actual );
#FileAssert.AreNotEqual( Stream expected, Stream actual );
#FileAssert.AreNotEqual( FileInfo expected, FileInfo actual );
#FileAssert.AreNotEqual( string expected, string actual );

#Directory Assert

#DirectoryAssert.AreEqual( DirectoryInfo expected, DirectoryInfo actual );
#DirectoryAssert.AreEqual( string expected, string actual );
#DirectoryAssert.AreNotEqual( DirectoryInfo expected, DirectoryInfo actual );
#DirectoryAssert.AreNotEqual( string expected, string actual );
#DirectoryAssert.IsEmpty( DirectoryInfo directory );
#DirectoryAssert.IsEmpty( string directory );
#DirectoryAssert.IsNotEmpty( DirectoryInfo directory );
#DirectoryAssert.IsNotEmpty( string directory );
#DirectoryAssert.IsWithin( DirectoryInfo expected, DirectoryInfo actual );
#DirectoryAssert.IsWithin( string expected, string actual );
#DirectoryAssert.IsNotWithin( DirectoryInfo expected, DirectoryInfo actual );
#DirectoryAssert.IsNotWithin( string expected, string actual );


#See also Propety and Delay Constraints