# minmay

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
