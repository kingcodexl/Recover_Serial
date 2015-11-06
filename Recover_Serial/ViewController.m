//
//  ViewController.m
//  Recover_Serial
//
//  Created by renhe.cn on 15/11/6.
//  Copyright © 2015年 renhe.cn. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (nonatomic, strong) UIView *moveView;   /**<<#注释#> */
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.moveView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 100, 100)];
    self.moveView.backgroundColor = [UIColor grayColor];
    self.moveView.center = self.view.center;
    [self.view addSubview:self.moveView];
}

#pragma mark - 触摸事件
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
}
- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    /*
     userInteractionEnabled=NO
     hidden=YES
     alpha=0~0.01
     没有实现开始触摸方法（注意是touchesBegan:withEvent:而不是移动和结束触摸事件）
     */
    
    /* 相关属性及其方法
     timestamp; 触摸产生变化的时间戳
     phase;  触摸周期内的各个状态
     tapCount; 短时间内点击的次数
     majorRadius;
     majorRadiusTolerance;
     window; 触摸式所在的窗口
     view;
     gestureRecognizers;
     force
     maximumPossibleForce
     - (CGPoint)locationInView:(nullable UIView *)view;
     - (CGPoint)previousLocationInView:(nullable UIView *)view;
     */
    // 1- 获得一个触摸对象,可以直接跳到想API,查看属性以及方法
    // 对于多点触摸,可能会返回多个触摸对象
    UITouch *touch = [touches anyObject];
   
    // 2- 当前位置
    CGPoint currentPoint = [touch locationInView:self.view];
    // 3- 前一个位置
    CGPoint previousPoint = [touch previousLocationInView:self.view];
    
    // 4- 移动原来中心位置
    CGPoint centPoint = self.moveView.center;
    // 5- 位置偏移
    CGPoint offset = CGPointMake(currentPoint.x - previousPoint.x, currentPoint.y - previousPoint.y);
    // 6- 改变中心位置,设置新位置
    self.moveView.center = CGPointMake(centPoint.x + offset.x, centPoint.y + offset.y);
    
}
- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

/**事件处理机制
 在iOS中发生触摸后，事件会加入到UIApplication事件队列（在这个系列关于iOS开发的第一篇文章中我们分析iOS程序原理的时候就说过程序运行后UIApplication会循环监听用户操作），UIApplication会从事件队列取出最前面的事件并分发处理，通常先分发给应用程序主窗口，主窗口会调用hitTest:withEvent:方法（假设称为方法A，注意这是UIView的方法），查找合适的事件触发视图（这里通常称为“hit-test view”）：
 
 在顶级视图（key window的视图）上调用pointInside:withEvent:方法判断触摸点是否在当前视图内；
 如果返回NO，那么A返回nil；
 如果返回YES，那么它会向当前视图的所有子视图（key window的子视图）发送hitTest:withEvent:消息，遍历所有子视图的顺序是从subviews数组的末尾向前遍历（从界面最上方开始向下遍历）。
 如果有subview的hitTest:withEvent:返回非空对象则A返回此对象，处理结束（注意这个过程，子视图也是根据pointInside:withEvent:的返回值来确定是返回空还是当前子视图对象的。并且这个过程中如果子视图的hidden=YES、userInteractionEnabled=NO或者alpha小于0.1都会并忽略）；
 如果所有subview遍历结束仍然没有返回非空对象，则A返回顶级视图；
 上面的步骤就是点击检测的过程，其实就是查找事件触发者的过程。触摸对象并非就是事件的响应者（例如上面第一个例子中没有重写KCImage触摸事件时，KCImge作为触摸对象，但是事件响应者却是UIViewController），检测到了触摸的对象之后，事件到底是如何响应呢？这个过程就必须引入一个新的概念“响应者链”。
 
 什么是响应者链呢？我们知道在iOS程序中无论是最后面的UIWindow还是最前面的某个按钮，它们的摆放是有前后关系的，一个控件可以放到另一个控件上面或下面，那么用户点击某个控件时是触发上面的控件还是下面的控件呢，这种先后关系构成一个链条就叫“响应者链”。在iOS中响应者链的关系可以用下图表示：
 
 
 当一个事件发生后首先看initial view能否处理这个事件，如果不能则会将事件传递给其上级视图（inital view的superView）；如果上级视图仍然无法处理则会继续往上传递；一直传递到视图控制器view controller，首先判断视图控制器的根视图view是否能处理此事件；如果不能则接着判断该视图控制器能否处理此事件，如果还是不能则继续向上传递；（对于第二个图视图控制器本身还在另一个视图控制器中，则继续交给父视图控制器的根视图，如果根视图不能处理则交给父视图控制器处理）；一直到window，如果window还是不能处理此事件则继续交给application（UIApplication单例对象）处理，如果最后application还是不能处理此事件则将其丢弃。
 
 这个过程大家理解起来并不难，关键问题是在这个过程中各个对象如何知道自己能不能处理该事件呢？对于继承UIResponder的对象，其不能处理事件有几个条件：
 
 userInteractionEnabled=NO
 hidden=YES
 alpha=0~0.01
 没有实现开始触摸方法（注意是touchesBegan:withEvent:而不是移动和结束触摸事件）
 
 
 当然前三点都是针对UIView控件或其子控件而言的，第四点可以针对UIView也可以针对视图控制器等其他UIResponder子类。对于第四种情况这里再次强调是对象中重写了开始触摸方法，则会处理这个事件，如果仅仅写了移动、停止触摸或取消触摸事件（或者这三个事件都重写了）没有写开始触摸事件，则此事件该对象不会进行处理。
 
 相信到了这里大家对于上面点击图片为什么不能拖拽已经很明确了。事实上通过前面的解释大家应该可以猜到即使KCImage实现了开始拖拽方法，如果在KCTouchEventViewController中设置KCImage对象的userInteractionEnabled为NO也是可以拖拽的。
 
 
 */
