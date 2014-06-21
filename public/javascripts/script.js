//滑动弹出效果
artDialog.slide = function (options) {
    var opt = options || {},
        api, aConfig, hide, wrap, top,
        duration = 400,steep=50,easing='linear';
    var config = {
        init: function(here){
            api = this;
            aConfig = api.config;
            wrap = api.DOM.wrap;
            top = parseInt(wrap[0].style.top);
            hide = parseInt(top + steep);
            wrap.css({'top': hide + 'px',opacity: 0})
                .animate({top: top + 'px',opacity: 1}, duration,easing, function () {
                    opt.init && opt.init.call(api, here);
                });
        },
        close: function(here){
            wrap.animate({top: top-steep + 'px',opacity: 0}, duration,easing, function () {
                opt.close && opt.close.call(this, here);
                aConfig.close = $.noop;
                api.close();
                wrap.css('top', hide + 'px');
            });
            return false;
        }
    };

    for (var i in opt) {
        if (config[i] === undefined) config[i] = opt[i];
    };

    return artDialog(config);
};

//

$(function(){
    // $('#nav a').hover(function(){
    //     $('#nav a').removeClass('selected');
    //     $(this).addClass('selected');
    // });
    $('.top').click(function(){
       $('body,html').animate({scrollTop:0},1000);
    });
    //banner效果
    $('#kv').carouFredSel({
        auto: {
            timeoutDuration:8000
        },
        prev:"#kv_prev",
        next:'#kv_next',
        responsive: true,
        direction   : "left",
        width: '100%',
        scroll: {
            fx:"crossfade",
            easing:'swing',
            duration:'500'
        },
        pagination: {
            container:"#kv_page",
            anchorBuilder:function( nr ) {
                return "<a href='javascript:;'></a>";
            }
        }
    });

    //作品滚动效果
    $('#works_con').carouFredSel({
        circular: false,
        infinite: false,
        auto: false,
        prev:"#works_prev",
        next:'#works_next',
        scroll:"easeInOutCirc",
        pagination: {
            container:"#works_page",
            anchorBuilder:function( nr ) {
                return "<a href='javascript:;'></a>";
            }
        }
    });

    //新闻滚动效果
    $('#news_con').carouFredSel({
        circular: false,
        infinite: false,
        auto: false,
        prev:"#news_prev",
        next:'#news_next',
        scroll:"easeInOutCirc",
        pagination: {
            container:"#news_page",
            anchorBuilder:function( nr ) {
                return "<a href='javascript:;'>"+nr+"</a>&nbsp;";
            }
        }
    });

    //关于我们滚动效果
    $('#about_con').carouFredSel({
        responsive: true,
        circular: false,
        infinite: false,
        auto: false,
        scroll: {
            fx:"crossfade",
            easing:'swing',
            duration:'500'
        }
    });
    $('#about_cat > a').bind('click',function(){
        $index = $('#about_cat > a').index($(this));
        $('#about_cat > a').removeClass('selected').eq($index).addClass('selected');
        $("#about_con").trigger("slideToPage", $index);
    });


    //关于我们滚动效果
    $('#service_con').carouFredSel({
        responsive: true,
        circular: false,
        infinite: false,
        auto: false,
        scroll: {
            fx:"crossfade",
            easing:'swing',
            duration:'500'
        }
    });
    $('#service_cat > a').bind('click',function(){
        $index = $('#service_cat > a').index($(this));
        $('#service_cat > a').removeClass('selected').eq($index).addClass('selected');
        $("#service_con").trigger("slideToPage", $index);
    });
});

function showwindow(id){
    $('#newinfo').find('h4').html($(id).parent().find('h4').html());
    $('#newinfo').find('p').html('POST TIME'+$(id).attr('data'));
    $('#newinfo').find('.con').html($(id).parent().find('.data_con').html());
    var news=art.dialog.slide({
        fixed: false,
        drag: false,
        resize: false,
        follow: null,
        title: '',
        lock: true,
        padding:"0px 0px",
        content: $('#newinfo').get(0),
        init:function(){
            $('.newinfo .close').click(function(){
                news.close();
            });
        }
    });
}

function showteam(id){
    var team=art.dialog.slide({
        fixed: false,
        drag: false,
        resize: false,
        follow: null,
        title: '',
        lock: true,
        padding:"0px 0px",
        content: $(id).parent().find('.data_con').find('.newinfo').get(0),
        init:function(){
            $('.newinfo .close').click(function(){
                team.close();
            });
        }
    });
}