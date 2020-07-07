state("BrightMemory_EP1-Win64-Shipping")
{
    bool isLoading: 0x02F020B0, 0x68, 0x228, 0xB4;
    string150 map: 0x02FFE968, 0x8A8, 0x0;
    float xPos: 0x02F953C0, 0x48, 0x240, 0x158, 0x1D0;
    float yPos: 0x02F953C0, 0x48, 0x240, 0x158, 0x1D4;
    float zPos: 0x02F953C0, 0x48, 0x240, 0x158, 0x1D8;
}

startup
{
    vars.startAfterLoad = false;
    vars.isLoading = false;
    vars.lastLoad = System.DateTime.Now;

    if (timer.CurrentTimingMethod == TimingMethod.RealTime)
	{        
		var timingMessage = MessageBox.Show (
			"This game uses Time without Loads (Game Time) as the main timing method.\n"+
			"LiveSplit is currently set to show Real Time (RTA).\n"+
			"Would you like to set the timing method to Game Time?",
			"LiveSplit | Bright Memory",
			MessageBoxButtons.YesNo,MessageBoxIcon.Question
		);
		
		if (timingMessage == DialogResult.Yes)
		{
			timer.CurrentTimingMethod = TimingMethod.GameTime;
		}
	}
}


start
{
    if(old.map == "/Game/Maps/Menu/VR_DemoStart" && current.map == "/Game/Maps/VR_Home")
        vars.startAfterLoad = true;

    if(vars.startAfterLoad && !vars.isLoading)
    {
        vars.startAfterLoad = false;
        return true;
    }
}

update
{
    if(current.isLoading)
    {
        vars.isLoading = true;
        vars.lastLoad = System.DateTime.Now;
    }
    else if(vars.isLoading)
    {
        print((System.DateTime.Now.Ticks/1000 - vars.lastLoad.Ticks/1000).ToString());
        if(System.DateTime.Now.Ticks/1000 - vars.lastLoad.Ticks/1000 > 1000.0f)
            vars.isLoading = false;
    }
}

split
{
    if(current.map != "/Game/Maps/VR_Level01")
        return false;

    var x = current.xPos;
    var y = current.yPos;
    var z = current.zPos;

    if(z < -500.0f && z > -1000.0f && x < 3400.0f && x > 3000.0f && y < 1110.0f && y > 600.0f)
        return true;
}


isLoading
{
    return vars.isLoading;
}