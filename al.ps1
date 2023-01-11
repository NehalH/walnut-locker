$scriptBlock = {
    # Get the path of the application to lock
    $path = 'C:\Users\ARAVINDA\Desktop\Python_HTML_flask'

    # Remove permissions for the application for all users
    icacls $path /deny *S-1-1-0:F

    # Create a new process object
    $process = New-Object System.Diagnostics.Process

    # Create a new processstartinfo object
    $startInfo = new-object System.Diagnostics.ProcessStartInfo

    # Assign the path of the application to FileName property of processstartinfo object
    $startInfo.FileName = $path

    # assign the processstartinfo object to startinfo property of process object
    $process.StartInfo = $startInfo

    # Prompt the user for a password
    $password = Read-Host -Prompt 'Enter Password:' -AsSecureString

    # Compare the entered password with the expected one
    if ($password -eq (ConvertTo-SecureString "pass" -AsPlainText -Force)) {
        # Re-add permissions for the application for all users
        icacls $path /grant *S-1-1-0:(OI)(CI)F
        # Start the application
        $process.Start()
        # Wait for the process to exit
        $process.WaitForExit()
    } else {
        Write-Host "Access denied"
    }

    # Remove permissions for the application for all users
    icacls $path /deny *S-1-1-0:F
}

$jobTrigger = New-JobTrigger -AtLogOn
Register-ScheduledJob -Name "Application_Locker" -ScriptBlock $scriptBlock -Trigger $jobTrigger


#Unregister-ScheduledJob -Name "Application_Locker"