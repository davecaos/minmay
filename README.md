# minmay
Minmay is a __naïve__ Erlang library for translating a file extention to MIME type or vice versa


``` 
   <<".jpg">> = minmay:extension(<<"image/jpeg">>).
   
   <<"image/jpeg">> = minmay:mime_type(<<".mpeg">>).
   
```
![GIF](http://31.media.tumblr.com/27a1fc6ca882304f04dc7aa1c3f63d88/tumblr_n6tdfuc3OW1tn7e6io1_r1_500.gif)
