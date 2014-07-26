// 生成用于URL安全传输的base64编码字符
function urlsafe_base64_encode(content)
{
    // base64_encode() 方法在 public/assets/js/base64_encode.js 中有定义
    return base64_encode(content).replace(/\+/g, '-').replace(/\//g, '_');
}

// 生成格式为 /rs-put/<EncodedEntryURI>/mimeType/<EncodedMimeType> 这样的字符串
function generate_rs_put_path(tbName, fileKey, mimeType)
{
    var mimeType = mimeType || 'application/octet-stream';

    var entryURI = tbName + ':' + fileKey;

    return '/rs-put/' + urlsafe_base64_encode(entryURI) + '/mimeType/' + urlsafe_base64_encode(mimeType);
}

// Secure random number generator interface.
(function( window, undefined ) {
  "use strict";

  var SecureRandom = window.SecureRandom = {
    // generates a random string.
    string : function(length){
      var text = "", possible = "abcdefghijklmnopqrstuvwxyz0123456789";
      for (var i = length - 1; i >= 0; i--) {
        text += possible.charAt(Math.floor(Math.random() * possible.length));
      };
      return text;
    },

    // generates a v4 random UUID (Universally Unique IDentifier).
    uuid : function(){
      return 'xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx'.replace(/[xy]/g, function(c) {
        var r = Math.random()*16|0, v = c == 'x' ? r : (r&0x3|0x8);
        return v.toString(16);
      });
    }
  };

})(window);