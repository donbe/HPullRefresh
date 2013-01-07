HPullRefresh
============

horizontal PullRefresh

<img src="https://raw.github.com/donbe/HPullRefresh/master/horizontalPullRefreshDemo/1BF565C3-F80E-4B32-9004-8E0AC720FF33.png" alt="HPullRefresh" title="HPullRefresh" style="display:block; margin: 10px auto 30px auto;" class="center">
<img src="https://raw.github.com/donbe/HPullRefresh/master/horizontalPullRefreshDemo/QQ20130107-1.png" alt="HPullRefresh" title="HPullRefresh" style="display:block; margin: 10px auto 30px auto;" class="center">

# Install
You can use [CocoaPods](https://github.com/CocoaPods/CocoaPods) install to you project.

or

drag horizontalPullRefresh folder to you project ,and add the QuartzCore.framework.

# How To Use
just a line code...

``` objective-c
- (void)viewDidLoad
{
    [super viewDidLoad];
    __block id blockself = self;
    [scrollview setContentSize:CGSizeMake(scrollview.bounds.size.width+1, scrollview.bounds.size.height)];
    [scrollview addHPullRefresh:^{
        [blockself performSelector:@selector(stopRefresh:) withObject:nil afterDelay:3.0];
    }];
    
    [scrollview startLoading];
}

-(void)stopRefresh:(id)sender{
    [scrollview stopLoading];
}
```

# Requirements
QuartzCore.framework


# Contact
[WeiBo](http://weibo.com/donbe)

[Twitter](https://twitter.com/donbe520)

