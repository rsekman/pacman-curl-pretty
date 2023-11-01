function fix_unit(s)
    {
        units="kMGTP";
        match(s, /(([0-9]+)(\.[0-9])?)([kMGT]?)/, m);
        unit = m[4];
        value = m[1];
        if ( length(m[2]) > 3) {
            value = strtonum(m[1])/1024;
            if (length(unit) != 0 )
                # index(str, "") = 0, so this will not work for kiB
                unit = substr(units, 1+index(units, unit), 1);
            else
                unit = "k"
        }
        if ( length(unit) != 0 )
            unit = unit "iB";
        else
            unit = "B"
        return sprintf("%5.1f %3s", value, unit);
    }
BEGIN {
    cols = strtonum(cols);
    infolen = int(cols * 6/10);
    proglen = cols - infolen;
}
{
    if ( NF != 12)
        next
    n = int((proglen - 8)*strtonum($1)/100);
    prog = sprintf(" [%s%s] %3d%",
           substr(hs, 0, n),
           substr(ds, 0, proglen-8-n),
           $1);
    info = sprintf("%s %s/s %8s", fix_unit($4), fix_unit($12), $11);
    padlen = infolen - length(fname) - length(info);
    printf "%s%*s%s%s", fname, padlen, "", info, prog;
}
