//
//  ViewController.m
//  AVAudioPlayer
//
//  Created by Karma on 16/5/18.
//  Copyright © 2016年 陈昆涛. All rights reserved.
//

#import "ViewController.h"
#import <AVFoundation/AVFoundation.h>

@interface ViewController ()<AVAudioPlayerDelegate>
@property (nonatomic,strong)AVAudioPlayer*player;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    [self player];
    
}
-(AVAudioPlayer *)player{
    if (_player == nil) {
        //获取mp3文件的路径
        NSString *urlString = [[NSBundle mainBundle] pathForResource:@"陈奕迅 - 阴天快乐" ofType:@"mp3"];
        NSURL *url = [NSURL fileURLWithPath: urlString];
        
        NSError *error = nil;
        //使用 initWithContentsOfURL: 方法，实例化AVAudioPlayer对象
        _player = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:&error];
        if (error) {
            NSLog(@"%@",error);
            
        //设置代理
            _player.delegate=self;
        }
        
        //准备播放
        [_player prepareToPlay];
    }
    return _player;
}
- (IBAction)stop:(id)sender {
    [self.player stop];
}
- (IBAction)play:(id)sender {
    [self.player play];
}
- (IBAction)pause:(id)sender {
    [self.player pause];
}
- (IBAction)changeVolume:(UISlider *)sender {
    self.player.volume =sender.value;
}

//此类代理方法具体应用:处理中断闹钟和电话等

/* 播放完毕后调用 */
- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag{
    NSLog(@"%s",__func__);
}
/* 当中断事件开始前调用 */
- (void)audioPlayerBeginInterruption:(AVAudioPlayer *)player{
    NSLog(@"%s",__func__);
    [self.player pause];
}
/* 当中断事件结束后调用*/
- (void)audioPlayerEndInterruption:(AVAudioPlayer *)player withFlags:(NSUInteger)flags{
    NSLog(@"%s",__func__);
    [self.player play];
}

@end
