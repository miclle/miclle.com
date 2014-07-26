//= require jquery.tagsinput.min

//= require utf8_encode
//= require base64_encode

//= require helper

//= require jquery.ui.core
//= require jquery.ui.widget

//= require JavaScript-Templates/tmpl
//= require JavaScript-Load-Image/load-image.min
//= require JavaScript-Canvas-to-Blob/canvas-to-blob

//= require jQuery-File-Upload/jquery.iframe-transport
//= require jQuery-File-Upload/jquery.fileupload
//= require jQuery-File-Upload/jquery.fileupload-process
//= require jQuery-File-Upload/jquery.fileupload-image
//= require jQuery-File-Upload/jquery.fileupload-validate
//= require jQuery-File-Upload/jquery.fileupload-ui


$(function(){

  if($('#photo-edit-form').size() > 0){

    function addSearchControl(map) {
      var geocoderBox   = $('<div class="geocoder-box"></div>'),
          searchControl = $('<div class="search-control"><i class="search icon"></i></div>'),
          searchBox     = $('<div class="search-box"><input class="search-input" type="text" placeholder="eg. 上海, 北京" /></div>');
      geocoderBox.append(searchControl);
      geocoderBox.append(searchBox);
      map.controls[google.maps.ControlPosition.LEFT_TOP].push(geocoderBox[0]);

      geocoderBox.on('click', '.search-control', function(event) {
        event.preventDefault();
        searchBox.toggle();
        if(searchBox.is(':visible')){
          searchBox.find('input').focus().select();
        }
      });

      geocoderBox.on('keyup keydown keypress', '.search-input', function(event) {
        if(event.keyCode == 13){
          var $input = $(this), geocoder = new google.maps.Geocoder();

          geocoder.geocode({address: $input.val()}, function(results, status){
            if (status == google.maps.GeocoderStatus.OK && results.length > 0) {
              var place = results[0];
              myLatLng = new google.maps.LatLng(place.geometry.location.lat(), place.geometry.location.lng());
              map.setZoom(12);
              map.panTo(myLatLng);
              searchBox.hide();
              $input.val('');
            }
          });
          return false;
        }
      });
    }

    $('#photo-tags').tagsInput({
      // 'autocomplete_url': url_to_autocomplete_api,
      // 'autocomplete': { option: value, option: value},
      'width':'100%',
      'height':'auto',
      'interactive':true,
      'defaultText':'添加标签',
      // 'onAddTag':callback_function,
      // 'onRemoveTag':callback_function,
      // 'onChange' : callback_function,
      'removeWithBackspace' : true,
      'minChars' : 0,
      'maxChars' : 0, //if not provided there is no limit,
      'placeholderColor' : '#CCC'
    });

    // Display Map
    var displayMap = function(latitude, longitude){

      var myLatLng,
          map = new google.maps.Map(document.getElementById("map"), { zoom: 1, streetViewControl: false }),
          marker,
          markerOptions = {
            // icon: 'images/beachflag.png',
          };

      if(latitude == "" || longitude == ""){
        myLatLng = new google.maps.LatLng(31.2314, 121.4738);
        map.panTo(myLatLng);
      }else{
        myLatLng = new google.maps.LatLng(latitude, longitude);

        map.panTo(myLatLng);
        map.setZoom(16);

        markerOptions.position = myLatLng;
        markerOptions.map = map;

        marker = new google.maps.Marker(markerOptions);
      }

      addSearchControl(map);

      $('.map-wrapper').removeClass('disabled-map');

      google.maps.event.addListener(map, 'click', function(event) {
        var latitude = event.latLng.lat();
        var longitude = event.latLng.lng();

        $('#photo_latitude').val(latitude);
        $('#photo_longitude').val(longitude);

        myLatLng = new google.maps.LatLng(latitude, longitude);

        if(marker == null){
          markerOptions.position = myLatLng;
          markerOptions.map = map;
          marker = new google.maps.Marker(markerOptions);
        }

        marker.setPosition(myLatLng)

        window.clearTimeout(window.timeoutId);
        window.timeoutId = window.setTimeout(function(){ map.panTo(myLatLng) }, 1000);

      });
    }

    displayMap($('#photo_latitude').val(), $('#photo_longitude').val());

    $('#add-photo-set').modal('setting', {
      onHide : function(){
        // $('#photo-set').prop('selectedIndex',0);
        $('#photo-set option[selected="selected"]').attr("selected", "selected");
      }
    });

    $('#photo-edit-form').on('change', '#photo-set', function(event) {
      event.preventDefault();
      /* Act on the event */
      if($(this).val() == 'add-set'){
        $('#add-photo-set').modal('show');
      }
    });
  }
});


$(function(){
  $('#fileupload').fileupload({
    url: 'http://up.qbox.me/upload',
    filesContainer: ".files",
    autoUpload: true,
    maxFileSize: 20000000, // 20MB
    loadImageMaxFileSize: 20000000, // 20MB
    previewMaxWidth: 280,
    previewMaxHeight: 190,
    previewCrop: true,
    // redirect: 'http://dev.miclle.com%s',
    formData: function(form){
      var data = form.serializeArray();
      var file = this.files[0];

      var user_uuid = $("meta[name='user-token']").attr('content')

      // 首先，为该文件生成一个唯一ID
      var fileUniqKey = SecureRandom.string(36);

      // 然后构造 input[name="action"] 的值
      // generate_rs_put_path() 在 assets/javascripts/helper.js 中有定义
      var actionString = generate_rs_put_path('miclle-private', user_uuid + '/' + fileUniqKey, file.type);

      // 给表单添加 input[name="action"] 字段
      data.push({name: 'action', value: actionString});

      // 构造 input[name="params"] 字段的值
      var params = [];

      params.push('user_uuid='+user_uuid);

      params.push('end_user=$(endUser)');
      params.push('name=$(fname)');                             //上传的原始文件名
      params.push('key=$(key)');                                //获得文件保存在空间中的资源名
      params.push('size=$(fsize)');                             //资源尺寸，单位为字节

      params.push('width=$(imageInfo.width)');
      params.push('height=$(imageInfo.height)');

      params.push('color_space=$(exif.ColorSpace.val)');        // 色域、色彩空间
      params.push('taken_at=$(exif.DateTime.val)');             // 创建时间
      params.push('exposure_time=$(exif.ExposureTime.val)');    // 曝光时间 即快门速度
      params.push('f_number=$(exif.FNumber.val)');              // 光圈系数
      params.push('focal_length=$(exif.FocalLength.val)');      // 焦距
      params.push('latitude=$(exif.GPSLatitude.val)');          // 纬度
      params.push('latitude_ref=$(exif.GPSLatitudeRef.val)');   // 纬度 方向
      params.push('longitude=$(exif.GPSLongitude.val)');        // 经度
      params.push('longitude_ref=$(exif.GPSLongitudeRef.val)'); // 经度 方向
      params.push('iso=$(exif.ISOSpeedRatings.val)');           // 感光度
      params.push('model=$(exif.Model.val)');                   // 型号 指设备型号

      // 给表单添加 input[name="params"] 字段
      data.push({name: 'params', value: params.join('&')});

      return data;
    }
  }).bind('fileuploadadded', function (e) {

    // $('#fileinput-button').hide(0);
    $('#drag-or-browse').hide(0);

  }).bind('fileuploadstopped', function (e) {

    $('#action-button-bar').show(0);
    // window.location = $('#homepage-button').attr('href');

  });

});