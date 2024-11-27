# Vim and Go: comment blocks

```vim
set comments=s1:/*,mb:*,ex:*/,://
set comments=s:/*,ex:*/,://

set comments=s:/*,mb: ,e:*/,:// -- error
set comments=s:/*,m: ,e:*/,:// -- error

set comments=s:/*,m:\ ,e:*/,://

set formatoptions=qjcor
set formatoptions=qjcor/
```


these 2 work but // doesn't continue

```vim
set comments=s:/*,e:*/,://
set formatoptions=qj
```

Pressing enter after Start of block auto inserts end of block
but // works as expected

```vim
set comments=s:/*,e:*/,://
set formatoptions=qjr
```

Pressing enter after Start of block works
and // works as expected

```vim
set comments=s:/*,e:*/,://
set formatoptions=qjo
set formatlistpat
```


```vim
set comments=s:/*,m:\ ,e:*/,://

```
