XPTemplate priority=lang-1

XPT ret " return 
return `1^;

XPT retn " return NULL;
return NULL;

XPT inc " #include <...>
#include <`stdio.h^>

XPT incc " #include "..."
#include "`stdio.h^"

XPT struct " structure 
struct `a^ {
    `data_type^ `member^;
`    `more...`
{{^    `data_type^ `member^;
`    `more...`
^`}}^};

XPT stru " struct a
struct `struct_name^ `^

XPT unsigned " unsigned
unsigned `int^ `^

XPT const " const
const `int^ `^

XPT typedef " typedef
typedef `old_type^ `new_type^;

XPT define " define
#define `MACRO^ `VALUE^

XPT strcmp "strcmp
strcmp(`s1^, `s2^)

XPT strncmp "strncmp
strcpy(`s1^, `s2^, `n^)

XPT strcpy "strcpy
strcpy(`src_str^, `dst_str^)

XPT strncpy "strncpy
strcpy(`src_str^, `dst_str^, `n^)

XPT strcat " strcat 
strcat(`src_str^, `dst_str^)

XPT strncat " strncat 
strcat(`src_str^, `dst_str^, `n^)

XPT sizeof " strncat 
sizeof(`type^)

XPT ifno " strncat 
if (`condition^) `do_something^;

