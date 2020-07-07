state("BrightMemory_EP1-Win64-Shipping")
{
    bool isLoading: 0x02F020B0, 0x68, 0x228, 0xB4;
    string150 map: 0x02FFE968, 0x8A8, 0x0;
}

startup
{
    vars.startAfterLoad = false;
    vars.isLoading = false;
    vars.lastLoad = System.DateTime.Now;
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

isLoading
{
    return vars.isLoading;
}