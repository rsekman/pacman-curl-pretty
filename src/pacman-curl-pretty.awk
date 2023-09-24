function fix_unit(s)
    {
        match(s, /([0-9]+(\.[0-9])?)([kMGT]?)/, m);
        if ( length(m[3]) != 0 )
            m[3] = m[3] "iB";
        else
            m[3] = "B"
        return sprintf("%6.1f %3s", m[1], m[3]);
    }
BEGIN {
    ORS = "";
    cols = strtonum(cols);
    infolen = cols * 6/10;
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
