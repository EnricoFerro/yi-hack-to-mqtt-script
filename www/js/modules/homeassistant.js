var APP = APP || {};

APP.homeassistant = (function ($) {

    function init() {
        registerEventHandler();
        fetchConfigs();
    }

    function registerEventHandler() {
        $(document).on("click", '#button-save', function (e) {
            saveConfigs();
        });
    }

    function fetchConfigs() {
        loadingStatusElem = $('#loading-status');
        loadingStatusElem.text("Loading...");

        $.ajax({
            type: "GET",
            url: 'cgi-bin/get_configs.sh?conf=homeassistant',
            dataType: "json",
            success: function(response) {
                loadingStatusElem.fadeOut(500);

                $.each(response, function (key, state) {
                    $('input[type="text"][data-key="' + key +'"]').prop('value', state);
                });
            },
            error: function(response) {
                console.log('error', response);
            }
        });
  
    }

    function saveConfigs() {
        var saveStatusElem;

        let configs = {};

        saveStatusElem = $('#save-status');
        saveStatusElem.text("Saving...");

        $('.configs-switch input[type="text"]').each(function () {
            configs[$(this).attr('data-key')] = $(this).prop('value');
        });

        $('.configs-switch input[type="password"]').each(function () {
            configs[$(this).attr('data-key')] = $(this).prop('value');
        });

        $.ajax({
            type: "POST",
            url: 'cgi-bin/set_configs.sh?conf=homeassistant',
            data: JSON.stringify(configs),
            dataType: "json",
            success: function(response) {
                saveStatusElem.text("Saved");
            },
            error: function(response) {
                saveStatusElem.text("Error while saving");
                console.log('error', response);
            }
        });

    }

    return {
        init: init
    };

})(jQuery);