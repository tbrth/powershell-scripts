function Disable-UserAccount {
    [CmdletBinding(SupportsShouldProcess=$True)]
    param (
        # Username of account to be disabled
        [Parameter(ValueFromPipeline=$True, Mandatory=$True)]
        [string]
        $UserName
    )
    
    begin {
        
        # Get today's date using the following formatting: YYYY-MM-DD
        # eg. 2019-08-16, YYYY-MM-DD
        $DateDisabled = Get-Date -Format "yyyy-MM-dd"

    }
    
    process {
        
        try {

            # Get all properties associated with targeted user account
            $UserToBeDisabled = Get-ADUser -Identity $UserName -Properties *

            # Establish dated annotation description to be set on targetd user account
            $NewDescription = "(Disabled $DateDisabled) $($UserToDisable.description)"

            if ($UserToBeDisabled.Enabled -eq $True) {

                Write-Host "Disabling $($UserToBeDisabled.givenname) $($UserToBeDisabled.surname) ($($UserToBeDisabled.samaccountname)).."
                Set-ADUser -Identity $UserName -Description $NewDescription -Enabled $False

            } else { # Skip if user account is already disabled

                Write-Host "$($UserToBeDisabled.givenname) $($UserToBeDisabled.surname) ($($UserToBeDisabled.samaccountname)) is already disabled..."
            }
        }
        catch {
            Write-Host "ERROR: $UserName doesn't exist"
        }
    }

}
