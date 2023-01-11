
    Add-Type -AssemblyName System.Windows.Forms
    Add-Type -AssemblyName System.Drawing

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

    #GUI
    #
    # Prompt the user for a password
    [System.Windows.Forms.Application]::EnableVisualStyles()

    $form = New-Object System.Windows.Forms.Form 
    $form.Visible = $false
    [void]$form.SuspendLayout()
    $form.Text = 'Password Window'
    $form.ClientSize = New-Object System.Drawing.Size(160,120) 
    $form.StartPosition = 'CenterScreen'
    $form.FormBorderStyle = [System.Windows.Forms.FormBorderStyle]::FixedSingle

    $CTRL_label1 = New-Object System.Windows.Forms.Label
    $CTRL_label1.Location = New-Object System.Drawing.Point(10,10) 
    $CTRL_label1.Size = New-Object System.Drawing.Size(280,20) 
    $CTRL_label1.Text = 'Please enter password:'
    $CTRL_label1.Name = 'Label1'
    [void]$form.Controls.Add($CTRL_label1) 

    $CTRL_password = New-Object System.Windows.Forms.TextBox
    $CTRL_password.Location = New-Object System.Drawing.Point(10,30) 
    $CTRL_password.PasswordChar = '*'
    $CTRL_password.Size = New-Object System.Drawing.Size(140,20) 
    $CTRL_password.MaxLength = 20
    $CTRL_password.Name = 'Password'
    [void]$form.Controls.Add($CTRL_password) 

    $CTRL_label2 = New-Object System.Windows.Forms.Label
    $CTRL_label2.Location = New-Object System.Drawing.Point(10,60) 
    $CTRL_label2.Size = New-Object System.Drawing.Size(280,20) 
    $CTRL_label2.ForeColor = [System.Drawing.Color]::Red
    $CTRL_label2.Text = ''
    $CTRL_label2.Name = 'Label2'
    [void]$form.Controls.Add($CTRL_label2) 

    $CTRL_Button = New-Object System.Windows.Forms.Button
    $CTRL_Button.Location = New-Object System.Drawing.Point(10,90)
    $CTRL_Button.Size = New-Object System.Drawing.Size(140,23)
    $CTRL_Button.Text = 'OK'
    $CTRL_Button.Name = 'OK'
    $CTRL_Button.Add_Click( { 
    
        $password= $CTRL_password.Text.Trim()

        #THE PASSWORD
        $actualpass= "pass"

        if ( $password -eq $actualpass ) {
        
            # Re-add permissions for the application for all users
            icacls $path /grant *S-1-1-0:F
            # Start the application
            $process.Start()
            # Wait for the process to exit
            $process.WaitForExit()
        
            [void]$form.Close()
            [void]$form.Dispose()
        }
        else {
            $CTRL_label2.Text = "Access Denied"
        }


     } )
    [void]$form.Controls.Add($CTRL_Button)

    [void]$form.ResumeLayout()

    $userInput = $form.ShowDialog()
    #
    #
    #

    # Remove permissions for the application for all users
    icacls $path /deny *S-1-1-0:F

#Execute the below command to unregister the Job
#Unregister-ScheduledJob -Name "Application_Locker"