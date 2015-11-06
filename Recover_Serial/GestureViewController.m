//
//  GestureViewController.m
//  Recover_Serial
//
//  Created by renhe.cn on 15/11/6.
//  Copyright © 2015年 renhe.cn. All rights reserved.
//

#import "GestureViewController.h"
#import "UIColor+Random.h"
@interface GestureViewController ()

@property (nonatomic, strong) UIImageView *imageView;   /**<<#注释#> */
@property (nonatomic, assign) NSUInteger *index;   /**<<#注释#> */

@end

@implementation GestureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addGesture];
    [self configSubView];
    // Do any additional setup after loading the view.
}
- (void)configSubView{
    self.imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 300, 300)];
    self.imageView.contentMode = UIViewContentModeScaleAspectFill;
    self.imageView.userInteractionEnabled = YES;
    self.imageView.image = [self getRandomColorImage];
    [self.view addSubview:self.imageView];
    self.imageView.center = self.view.center;
}

- (void)addGesture{
    // 一  添加点击手势
    // 1- 创建点击手势识别对象
    UITapGestureRecognizer *tapGetsture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapGesture:)];
    // 2- 设置属性
    tapGetsture.numberOfTapsRequired = 1; // 设置点击次数
    tapGetsture.numberOfTouchesRequired = 1;// 点击的手指数
    // 3- 添加手势到对象
    [self.view addGestureRecognizer:tapGetsture];
    
    
    // 二  添加 长按手势
    UILongPressGestureRecognizer *longGestrue = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longPressGestrue:)];
    longGestrue.minimumPressDuration = 0.5; // 设置长按市场
    //longGestrue.allowableMovement = YES;
    [self.imageView addGestureRecognizer:longGestrue];// 长按删除
    
    // 三 捏合shoushi
    UIPinchGestureRecognizer *pinGesture = [[UIPinchGestureRecognizer alloc]initWithTarget:self action:@selector(pinGestrue:)];
    [self.view addGestureRecognizer:pinGesture];
    
    // 四 旋转
    UIRotationGestureRecognizer *rotationGesture = [[UIRotationGestureRecognizer alloc]initWithTarget:self action:@selector(rotationGestrue:)];
    [self.view addGestureRecognizer:rotationGesture];
    
    // 五 拖动
    UIPanGestureRecognizer *panGestruere = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(panGesture:)];
    [_imageView addGestureRecognizer:panGestruere];
    
    // 六 轻扫-向右
    UISwipeGestureRecognizer *swipGestrueRight = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipGesture:)];
    swipGestrueRight.direction = UISwipeGestureRecognizerDirectionRight;
    [self.view addGestureRecognizer:swipGestrueRight];
    
    // 七 轻扫-向左
    UISwipeGestureRecognizer *swipGestrueLeft = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipGesture:)];
    swipGestrueRight.direction = UISwipeGestureRecognizerDirectionLeft;
    [self.view addGestureRecognizer:swipGestrueLeft];
    
    
    // 八 手势冲突
    [panGestruere requireGestureRecognizerToFail:swipGestrueLeft];
    [panGestruere requireGestureRecognizerToFail:swipGestrueRight];
    [longGestrue requireGestureRecognizerToFail:panGestruere];
}

- (void)swipGesture:(UISwipeGestureRecognizer *)swipGestrue{
    if (swipGestrue.direction == UISwipeGestureRecognizerDirectionRight) {
        [self nextImage];
    }else if (swipGestrue.direction == UISwipeGestureRecognizerDirectionLeft){
        [self upImage];
    }
}
- (void)swipGestureRight:(UISwipeGestureRecognizer *)swipGesture{
    
}
- (void)panGesture:(UIPanGestureRecognizer *)panGesture{
    if (panGesture.state == UIGestureRecognizerStateChanged) {
        CGPoint translation = [panGesture translationInView:self.view];
        self.imageView.transform = CGAffineTransformMakeTranslation(translation.x, translation.y);
    }else if (panGesture.state == UIGestureRecognizerStateEnded){
        self.imageView.transform = CGAffineTransformIdentity;
    }
}
- (void)rotationGestrue:(UIRotationGestureRecognizer *)rotationGestrue{
    if (rotationGestrue.state == UIGestureRecognizerStateChanged) {
        self.imageView.transform = CGAffineTransformMakeRotation(rotationGestrue.rotation);
        
    }else if (rotationGestrue.state == UIGestureRecognizerStateEnded){
        self.imageView.transform = CGAffineTransformIdentity;
    }
}
- (void)pinGestrue:(UIPinchGestureRecognizer *)pinGesture{
    if (pinGesture.state == UIGestureRecognizerStateChanged) {
        self.imageView.transform = CGAffineTransformMakeScale(pinGesture.scale, pinGesture.scale);
        
    }else if (pinGesture.state == UIGestureRecognizerStateEnded){
        [UIView animateWithDuration:5 animations:^{
            self.imageView.transform = CGAffineTransformIdentity;
        }];
    }
}
- (void)longPressGestrue:(UILongPressGestureRecognizer *)longGestrue{
    if (longGestrue.state == UIGestureRecognizerStateBegan) {
        self.imageView.image = [self getRandomColorImage];
    }
}

- (void)tapGesture:(UITapGestureRecognizer *)tapGetsture{
    BOOL hidden = !self.navigationController.navigationBarHidden;
    [self.navigationController setNavigationBarHidden:hidden];
}

#pragma mark - 切换image
- (void)nextImage{
    self.imageView.image = [self getRandomColorImage];
}
- (void)upImage{
    self.imageView.image = [self getRandomColorImage];
}
#pragma mark - 模拟图片
- (UIImage *)getRandomColorImage{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 300, 300)];
    view.backgroundColor = [UIColor randomColor];
    return [self getImageFromView:view];
}
// 把UIView 转换成图片
-(UIImage *)getImageFromView:(UIView *)view{
    UIGraphicsBeginImageContext(view.bounds.size);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//
-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer{
    //NSLog(@"%i,%i",gestureRecognizer.view.tag,otherGestureRecognizer.view.tag);
    
    //注意，这里控制只有在UIImageView中才能向下传播，其他情况不允许
    if ([otherGestureRecognizer.view isKindOfClass:[UIImageView class]]) {
        return YES;
    }
    return NO;
}

/**
 
##### 手势	说明
 UITapGestureRecognizer	点按手势
 UIPinchGestureRecognizer	捏合手势
 UIPanGestureRecognizer	拖动手势
 UISwipeGestureRecognizer	轻扫手势，支持四个方向的轻扫，但是不同的方向要分别定义轻扫手势
 UIRotationGestureRecognizer	旋转手势
 UILongPressGestureRecognizer	长按手势
所有的手势操作都继承于UIGestureRecognizer，这个类本身不能直接使用。这个类中定义了这几种手势共有的一些属性和方法(下表仅列出常用属性和方法)：
 
 
 名称	说明
 属性
 @property(nonatomic,readonly) UIGestureRecognizerState state;	手势状态
 @property(nonatomic, getter=isEnabled) BOOL enabled;	手势是否可用
 @property(nonatomic,readonly) UIView *view;	触发手势的视图（一般在触摸执行操作中我们可以通过此属性获得触摸视图进行操作）
 @property(nonatomic) BOOL delaysTouchesBegan;	手势识别失败前不执行触摸开始事件，默认为NO；如果为YES，那么成功识别则不执行触摸开始事件，失败则执行触摸开始事件；如果为NO，则不管成功与否都执行触摸开始事件；
 方法
 - (void)addTarget:(id)target action:(SEL)action;	添加触摸执行事件
 - (void)removeTarget:(id)target action:(SEL)action;	移除触摸执行事件
 - (NSUInteger)numberOfTouches;	触摸点的个数（同时触摸的手指数）
 - (CGPoint)locationInView:(UIView*)view;	在指定视图中的相对位置
 - (CGPoint)locationOfTouch:(NSUInteger)touchIndex inView:(UIView*)view;	触摸点相对于指定视图的位置
 - (void)requireGestureRecognizerToFail:(UIGestureRecognizer *)otherGestureRecognizer;	指定一个手势需要另一个手势执行失败才会执行
 代理方法
 - (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer;	一个控件的手势识别后是否阻断手势识别继续向下传播，默认返回NO；如果为YES，响应者链上层对象触发手势识别后，如果下层对象也添加了手势并成功识别也会继续执行，否则上层对象识别后则不再继续传播；
 
 
 ######手势状态
 
 这里着重解释一下上表中手势状态这个对象。在六种手势识别中，只有一种手势是离散手势，它就是UITapGestureRecgnier。离散手势的特点就是一旦识别就无法取消，而且只会调用一次手势操作事件（初始化手势时指定的触发方法）。换句话说其他五种手势是连续手势，连续手势的特点就是会多次调用手势操作事件，而且在连续手势识别后可以取消手势。从下图可以看出两者调用操作事件的次数是不同的：
 
 typedef NS_ENUM(NSInteger, UIGestureRecognizerState) {
 UIGestureRecognizerStatePossible,   // 尚未识别是何种手势操作（但可能已经触发了触摸事件），默认状态
 
 UIGestureRecognizerStateBegan,      // 手势已经开始，此时已经被识别，但是这个过程中可能发生变化，手势操作尚未完成
 UIGestureRecognizerStateChanged,    // 手势状态发生转变
 UIGestureRecognizerStateEnded,      // 手势识别操作完成（此时已经松开手指）
 UIGestureRecognizerStateCancelled,  // 手势被取消，恢复到默认状态
 
 UIGestureRecognizerStateFailed,     // 手势识别失败，恢复到默认状态
 
 UIGestureRecognizerStateRecognized = UIGestureRecognizerStateEnded // 手势识别完成，同UIGestureRecognizerStateEnded
 };
 
 
 对于离散型手势UITapGestureRecgnizer要么被识别，要么失败，点按（假设点按次数设置为1，并且没有添加长按手势）下去一次不松开则此时什么也不会发生，松开手指立即识别并调用操作事件，并且状态为3（已完成）。
 但是连续手势要复杂一些，就拿旋转手势来说，如果两个手指点下去不做任何操作，此时并不能识别手势（因为我们还没旋转）但是其实已经触发了触摸开始事件，此时处于状态0；如果此时旋转会被识别，也就会调用对应的操作事件，同时状态变成1（手势开始），但是状态1只有一瞬间；紧接着状态变为2（因为我们的旋转需要持续一会），并且重复调用操作事件（如果在事件中打印状态会重复打印2）；松开手指，此时状态变为3，并调用1次操作事件。
 为了大家更好的理解这个状态的变化，不妨在操作事件中打印事件状态，会发现在操作事件中的状态永远不可能为0（默认状态），因为只要调用此事件说明已经被识别了。前面也说过，手势识别从根本还是调用触摸事件而完成的，连续手势之所以会发生状态转换完全是由于触摸事件中的移动事件造成的，没有移动事件也就不存在这个过程中状态变化。
 
 
 ####手势冲突
 
 细心的童鞋会发现在上面的演示效果图中当切换到下一张或者上一张图片时并没有轻扫图片而是在空白地方轻扫完成，原因是如果我轻扫图片会引起拖动手势而不是轻扫手势。换句话说，两种手势发生了冲突。
 
 冲突的原因很简单，拖动手势的操作事件是在手势的开始状态（状态1）识别执行的，而轻扫手势的操作事件只有在手势结束状态（状态3）才能执行，因此轻扫手势就作为了牺牲品没有被正确识别。我们理想的情况当然是如果在图片上拖动就移动图片，如果在图片上轻扫就翻动图片。如何解决这个冲突呢？
 
 在iOS中，如果一个手势A的识别部分是另一个手势B的子部分时，默认情况下A就会先识别，B就无法识别了。要解决这个冲突可以利用- (void)requireGestureRecognizerToFail:(UIGestureRecognizer *)otherGestureRecognizer;方法来完成。正是前面表格中UIGestureRecognizer的最后一个方法，这个方法可以指定某个手势执行的前提是另一个手势失败才会识别执行。也就是说如果我们指定拖动手势的执行前提为轻扫手势失败就可以了，这样一来当我们手指轻轻滑动时系统会优先考虑轻扫手势，如果最后发现该操作不是轻扫，那么就会执行拖动。只要将下面的代码添加到添加手势之后就能解决这个问题了（注意为了更加清晰的区分拖动和轻扫[模拟器中拖动稍微快一点就识别成了轻扫]，这里将长按手势的前提设置为拖动失败，避免演示拖动时长按手势会被识别）：
 
 
#########解决在图片上滑动时拖动手势和轻扫手势的冲突
 [panGesture requireGestureRecognizerToFail:swipeGestureToRight];
 [panGesture requireGestureRecognizerToFail:swipeGestureToLeft];
 //解决拖动和长按手势之间的冲突
 [longPressGesture requireGestureRecognizerToFail:panGesture];

 
############继续事件传递
 我们知道在iOS的触摸事件中，事件触发是根据响应者链进行的，上层触摸事件执行后就不再向下传播。默认情况下手势也是类似的，先识别的手势会阻断手势识别操作继续传播。那么如何让两个有层次关系并且都添加了手势的控件都能正确识别手势呢？答案就是利用代理的-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer方法。这个代理方法默认返回NO，会阻断继续向下识别手势，如果返回YES则可以继续向下传播识别。
 
 下面的代码控制演示了当在图片上长按时同时可以识别控制器视图的长按手势（注意其中我们还控制了只有在UIImageView中操作的手势才能向下传递，如果不控制则所有控件都可以向下传递）
 */

@end
