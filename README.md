HPullRefresh
============

horizontal PullRefresh

<img src="https://raw.github.com/donbe/HPullRefresh/master/horizontalPullRefreshDemo/QQ20130107-1.png" alt="HPullRefresh" title="HPullRefresh" style="display:block; margin: 10px auto 30px auto;" class="center">


# How To Use
just a line code...
    __block id blockself = self;
    [scrollview setContentSize:CGSizeMake(scrollview.bounds.size.width+1, scrollview.bounds.size.height)];
    [scrollview addHPullRefresh:^{
        [blockself performSelector:@selector(stopRefresh:) withObject:nil afterDelay:3.0];
    }];
    
    [scrollview startLoading];
    
# Requirements
QuartzCore.framework


# Contact
[link](http://weibo.com/donbe "归先人")
