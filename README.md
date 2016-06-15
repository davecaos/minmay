# minmay
Minmay is an Erlang library for mapping a file extention to MIME type or vice versa


Example:
``` 
Eshell V7.0  (abort with ^G)
1>  minmay:start().
ok
2> minmay:get_mime_type(<<"vacations.jpg">>).
<<"image/jpeg">>
3> minmay:get_extension(<<"image/jpeg">>).
<<".jpg">>
4> minmay:stop().
ok
   
```
![GIF](http://1.bp.blogspot.com/-yHRkA0tfIds/T8--B9NF1bI/AAAAAAAAC9k/_XLHURp5BeE/s1600/Lynn+Minmay+-+Shao+Pai+Ron.gif)
