# Function to monitor changes to critical files
function Monitor-FileChanges {
    param (
        [string]$Path,
        [string]$LogFile = "C:\FileChangeLog.txt"
    )

    # Set up a file system watcher
    $watcher = New-Object System.IO.FileSystemWatcher
    $watcher.Path = $Path
    $watcher.IncludeSubdirectories = $true
    $watcher.EnableRaisingEvents = $true

    # Event handlers for file changes
    $onChange = Register-ObjectEvent $watcher Changed -SourceIdentifier FileChanged -Action {
        $event = $Event.SourceEventArgs
        Add-Content -Path $LogFile -Value "File changed: $($event.FullPath) at $(Get-Date)"
    }
    $onCreate = Register-ObjectEvent $watcher Created -SourceIdentifier FileCreated -Action {
        $event = $Event.SourceEventArgs
        Add-Content -Path $LogFile -Value "File created: $($event.FullPath) at $(Get-Date)"
    }
    $onDelete = Register-ObjectEvent $watcher Deleted -SourceIdentifier FileDeleted -Action {
        $event = $Event.SourceEventArgs
        Add-Content -Path $LogFile -Value "File deleted: $($event.FullPath) at $(Get-Date)"
    }
    $onRename = Register-ObjectEvent $watcher Renamed -SourceIdentifier FileRenamed -Action {
        $event = $Event.SourceEventArgs
        Add-Content -Path $LogFile -Value "File renamed: $($event.OldFullPath) to $($event.FullPath) at $(Get-Date)"
    }

    Write-Host "Monitoring changes to $Path. Log file: $LogFile"
}

# Example usage:
# Monitor-FileChanges -Path "C:\CriticalData" -LogFile "C:\FileChangeLog.txt"
