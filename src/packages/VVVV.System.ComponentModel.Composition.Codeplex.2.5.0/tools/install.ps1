param($installPath, $toolsPath, $package, $project)

# Set the copy local flag to false
foreach ($reference in $project.Object.References)
{
    if ($reference.Name -eq "System.ComponentModel.Composition.Codeplex")
    {
        $reference.CopyLocal = $false;
    }
}