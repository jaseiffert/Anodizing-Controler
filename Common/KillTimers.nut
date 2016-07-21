function killTimers()
{
    local root = getroottable();
    foreach (k,v in root) {
        if (v instanceof Timer)
            root[k] = null;
    }
}

killTimers();