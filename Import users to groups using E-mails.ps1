# Set the path to your CSV file
$csvPath = "C:\temp\users.csv"

# Set the name of the security group you want to add the users to
$groupName = "Test_Groups"

# Import the CSV file
$users = Import-Csv $csvPath

# Loop through each user in the CSV file
foreach ($user in $users) {
    # Get the user's email address from the CSV file
    $email = $user.Email

    # Search for the user's AD account by email
    $adUser = Get-ADUser -Filter {EmailAddress -eq $email} -Properties MemberOf

    # If the user's AD account was found, add them to the specified security group
    if ($adUser) {
        Add-ADGroupMember -Identity $groupName -Members $adUser
        Write-Host "Added $($adUser.SamAccountName) to $groupName"
    } else {
        Write-Host "Could not find user with email $email in AD"
    }
}