# minmay

[![Travis](https://img.shields.io/travis/davecaos/minmay.svg?style=flat-square)](https://travis-ci.org/davecaos/minmay)
[![Hex.pm](https://img.shields.io/hexpm/v/minmay.svg?style=flat-square)](https://hex.pm/packages/minmay)
[![License](http://img.shields.io/hexpm/l/minmay.svg?style=flat)](https://hex.pm/packages/minmay)
[![Hex.pm](https://img.shields.io/hexpm/dt/minmay.svg?style=flat-square)](https://hex.pm/packages/minmay)

Minmay is an Erlang library for mapping a file extention to MIME type or vice versa

The conversion proplist is cached using two [ETS tables](http://learnyousomeerlang.com/ets) (extensions and mime_types)

It was based in [@samuelneff's](https://github.com/samuelneff/) [MimeTypeMap](https://github.com/samuelneff/MimeTypeMap)

---------
Example:
```erlang
Eshell V7.0  (abort with ^G)
1>  minmay:start().
ok
2> minmay:from_extension(".jpg").
"image/jpeg" 
2> minmay:from_filename("vacations.jpg").
"image/jpeg"
3> minmay:from_mime_type("image/jpeg").
".jpg"
4> minmay:stop().
ok
   
```
![GIF](http://1.bp.blogspot.com/-yHRkA0tfIds/T8--B9NF1bI/AAAAAAAAC9k/_XLHURp5BeE/s1600/Lynn+Minmay+-+Shao+Pai+Ron.gif)
