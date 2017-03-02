//
//  StoryPartViewController.m
//  AV Storybook
//
//  Created by Callum Davies on 2017-02-26.
//  Copyright © 2017 Callum Davies. All rights reserved.
//

#import "StoryPartViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "Story.h"

@interface StoryPartViewController () <UIImagePickerControllerDelegate, UINavigationControllerDelegate, AVAudioRecorderDelegate>


@property (weak, nonatomic) IBOutlet UIImageView *storyPartImageView;

@property (nonatomic, strong) AVPlayer *player;
@property (nonatomic, strong) AVAudioRecorder *recorder;
@property (nonatomic, strong) Story *story;

@end

@implementation StoryPartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.storyPartImageView.userInteractionEnabled = YES;
    
    self.story = [Story new];
//    self.storyPartImageView.image = self.story.pictureDisplayed;
    UITapGestureRecognizer *imageTapper = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(playAudio)];
    [self.storyPartImageView addGestureRecognizer:imageTapper];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)pickPhotoButtonPressed:(UIButton *)sender
{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    [self presentViewController:picker animated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    UIImage *image = info[@"UIImagePickerControllerOriginalImage"];
    self.story.pictureDisplayed = image;
    self.storyPartImageView.image = self.story.pictureDisplayed;

    [self dismissViewControllerAnimated:YES completion:nil];
}


- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [self dismissViewControllerAnimated:YES completion:nil];
}



- (IBAction)audioButtonPressed:(UIButton *)sender
{
    NSDictionary *recordSettings = @{
                                     AVFormatIDKey:  @(kAudioFormatLinearPCM),
                                     AVSampleRateKey: @(44100.0),
                                     AVNumberOfChannelsKey: @(2),
                                     AVLinearPCMBitDepthKey: @(16),
                                     AVLinearPCMIsBigEndianKey: @(NO),
                                     AVLinearPCMIsFloatKey: @(NO)
                                     };
    
    
    // Figure out the documents directory (writable)
    
    NSString *docPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, TRUE)[0];
    NSString *filePath = [docPath stringByAppendingPathComponent:@"file.aiff"];
    NSURL *fileURL = [NSURL fileURLWithPath:filePath];
    
    
    
    // create recorder
    NSError *error;
    AVAudioRecorder *recorder = [[AVAudioRecorder alloc] initWithURL:fileURL settings:recordSettings error:&error];
    
    [recorder prepareToRecord];
    [recorder recordForDuration:5];
    
    
    self.recorder = recorder;
    recorder.delegate = self;
}

- (void)audioRecorderDidFinishRecording:(AVAudioRecorder *)recorder successfully:(BOOL)flag {
    
    self.story.storyAudio = recorder.url;
    
}

- (void)playAudio {
    AVPlayer *player = [AVPlayer playerWithURL:self.story.storyAudio];
    
    [player play];
    
    self.player = player;
    
    AVPlayerLayer *playerLayer = [AVPlayerLayer playerLayerWithPlayer:player];
    
    [self.view.layer addSublayer:playerLayer];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
