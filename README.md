# minmay
Minmay is a __naïve__ Erlang library for translating a file extention to MIME type or vice versa


``` 
   <<".jpg">> = minmay:extension(<<"image/jpeg">>).
   
   <<"image/jpeg">> = minmay:mime_type(<<".mpeg">>).
   
```
![GIF](http://1.bp.blogspot.com/-yHRkA0tfIds/T8--B9NF1bI/AAAAAAAAC9k/_XLHURp5BeE/s1600/Lynn+Minmay+-+Shao+Pai+Ron.gif)
