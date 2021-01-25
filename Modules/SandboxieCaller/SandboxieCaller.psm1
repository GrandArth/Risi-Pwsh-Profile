function Start-Tim {
Write-Output "Rising QQ protect";
& "D:\Program Files\Sandboxie-Plus\Start.exe" /box:Tim "C:\Program Files (x86)\Common Files\Tencent\QQProtect\Bin\QQProtect.exe";
Write-Output "Rising Tim";
& "D:\Program Files\Sandboxie-Plus\Start.exe" /box:Tim "C:\Program Files (x86)\Tencent\TIM\Bin\TIM.exe";
#The first string is the location of your sandboxie programme, append your box name to /box:
#The last string indicate the exe in the virtual environment. 
}