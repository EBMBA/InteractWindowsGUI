function InteractWindowsGUI {
    param (
        [string]$Option
    )
    Begin{
        $Signature = @"
        [DllImport("user32.dll")]
        static extern void keybd_event(byte bVk, byte bScan, uint dwFlags, UIntPtr dwExtraInfo);
        //WIN + CTRL + D: Create a new desktop
        public static void CreateVirtualDesktopInWin10(){
            //Key down
            keybd_event((byte)0x5B, 0, 0, UIntPtr.Zero); //Left Windows key 
            keybd_event((byte)0x11, 0, 0, UIntPtr.Zero); //CTRL
            keybd_event((byte)0x44, 0, 0, UIntPtr.Zero); //D
            //Key up
            keybd_event((byte)0x5B, 0, (uint)0x2, UIntPtr.Zero);
            keybd_event((byte)0x11, 0, (uint)0x2, UIntPtr.Zero);
            keybd_event((byte)0x44, 0, (uint)0x2, UIntPtr.Zero);
        }
        //WIN + SHIFT + Left ARROW: Move app to left screen
        public static void MoveToLeftScreen(){
            //Key down
            keybd_event((byte)0x5B, 0, 0, UIntPtr.Zero); //Left Windows key
            keybd_event((byte)0xA0, 0, 0, UIntPtr.Zero); //Left Shif Key
            keybd_event((byte)0x25, 0, 0, UIntPtr.Zero); //Left Arrow Key
            //Key Up
            keybd_event((byte)0x5B, 0, (uint)0x2, UIntPtr.Zero); //Left Windows key
            keybd_event((byte)0xA0, 0, (uint)0x2, UIntPtr.Zero); //Left Shif Key
            keybd_event((byte)0x25, 0, (uint)0x2, UIntPtr.Zero); //Left Arrow Key
        }
        //WIN + Left ARROW: Move app to left side of the screen
        public static void MoveToLeftSide(){
            //Key down
            keybd_event((byte)0x5B, 0, 0, UIntPtr.Zero); //Left Windows key
            keybd_event((byte)0x25, 0, 0, UIntPtr.Zero); //Right Arrow Key
            //Key Up
            keybd_event((byte)0x5B, 0, (uint)0x2, UIntPtr.Zero); //Left Windows key
            keybd_event((byte)0x25, 0, (uint)0x2, UIntPtr.Zero); //Left Arrow Key
        }
        //WIN + SHIFT + Right ARROW: Move app to right screen
        public static void MoveToRightScreen(){
            //Key down
            keybd_event((byte)0x5B, 0, 0, UIntPtr.Zero); //Left Windows key
            keybd_event((byte)0xA0, 0, 0, UIntPtr.Zero); //Left Shif Key
            keybd_event((byte)0x27, 0, 0, UIntPtr.Zero); //Right Arrow Key
            //Key Up
            keybd_event((byte)0x5B, 0, (uint)0x2, UIntPtr.Zero); //Left Windows key
            keybd_event((byte)0xA0, 0, (uint)0x2, UIntPtr.Zero); //Left Shif Key
            keybd_event((byte)0x27, 0, (uint)0x2, UIntPtr.Zero); //Right Arrow Key
        }
        //WIN + Right ARROW: Move app to right side of the screen
        public static void MoveToRightSide(){
            //Key down
            keybd_event((byte)0x5B, 0, 0, UIntPtr.Zero); //Left Windows key
            keybd_event((byte)0x27, 0, 0, UIntPtr.Zero); //Right Arrow Key
            //Key Up
            keybd_event((byte)0x5B, 0, (uint)0x2, UIntPtr.Zero); //Left Windows key
            keybd_event((byte)0x27, 0, (uint)0x2, UIntPtr.Zero); //Right Arrow Key
        }
        //WIN + UP ARROW: Maximize 
        public static void Maximize(){
            //Key down
            keybd_event((byte)0x5B, 0, 0, UIntPtr.Zero); //Left Windows key
            keybd_event((byte)0x26, 0, 0, UIntPtr.Zero); //Up Arrow Key
            //Key Up
            keybd_event((byte)0x5B, 0, (uint)0x2, UIntPtr.Zero); //Left Windows key
            keybd_event((byte)0x26, 0, (uint)0x2, UIntPtr.Zero); //Up Arrow Key
        }
"@
    }
    Process{
        $KeyShortcut = Add-Type -MemberDefinition $Signature  -Name InteractWindowsGUI -UsingNamespace System.Threading -PassThru
        switch ($Option) {
            'NewVirtualDesktop' { 
                $KeyShortcut::CreateVirtualDesktopInWin10()
            }
            'MoveToLeftScreen' { 
                $KeyShortcut::MoveToLeftScreen()
            }
            'MoveToLeftSide' { 
                $KeyShortcut::MoveToLeftSide()
            }
            'MoveToRightScreen' { 
                $KeyShortcut::MoveToRightScreen()
            }
            'MoveToRightSide' { 
                $KeyShortcut::MoveToRightSide()
            }
            'Maximize' { 
                $KeyShortcut::Maximize()
            }
            Default {}
        }
    }
}

Export-ModuleMember -Function InteractWindowsGUI
