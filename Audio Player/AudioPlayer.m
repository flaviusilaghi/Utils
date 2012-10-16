//
//  AudioPlayer.m
//  Contact Management
//
//  Created by silaghi flaviu on 6/1/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AudioPlayer.h"
#import "lame.h"

@implementation AudioPlayer
@synthesize delegate;

-(id) initWithMemoName:(NSString*) name {
    self=[super init];
    if (self) {
       
        NSArray *dirPaths;
        NSString *docsDir;
        NSString *soundName=[NSString stringWithFormat:@"%@.aac",name];
        
        dirPaths = NSSearchPathForDirectoriesInDomains(
                                                       NSDocumentDirectory, NSUserDomainMask, YES);
        docsDir = [dirPaths objectAtIndex:0];
        soundFilePath = [docsDir
                                   stringByAppendingPathComponent:soundName];
        
        NSURL *soundFileURL = [NSURL fileURLWithPath:soundFilePath];
        
        NSDictionary *recordSettings = [NSDictionary 
                                        dictionaryWithObjectsAndKeys:
                                        [NSNumber numberWithInt:AVAudioQualityMin],
                                        AVEncoderAudioQualityKey,
                                        [NSNumber numberWithInt:16], 
                                        AVEncoderBitRateKey,
                                        [NSNumber numberWithInt: 2], 
                                        AVNumberOfChannelsKey,
                                        [NSNumber numberWithFloat:44100.0], 
                                        AVSampleRateKey,
                                        [NSNumber numberWithInt: kAudioFormatMPEG4AAC], AVFormatIDKey,
                                        nil];
        
        NSError *error = nil;
        
        audioRecorder = [[AVAudioRecorder alloc]
                         initWithURL:soundFileURL
                         settings:recordSettings
                         error:&error];
        
        if (error)
        {
            NSLog(@"error: %@", [error localizedDescription]);
            
        }    
    }
    return self;
}

#pragma mark- Main Actions


-(void) recordAudio
{
    [audioRecorder prepareToRecord];
    if (!audioRecorder.recording)
    {
        
        [audioRecorder record];
    }
}

-(void)stop
{
    if (audioRecorder.recording)
    {
        [audioRecorder stop];

    } else if (audioPlayer.playing) {
        [audioPlayer stop];
    }
}

-(void) playAudio
{
    if (!audioRecorder.recording)
    {
        
        NSError *error;
        NSURL *soundFileURL = [NSURL fileURLWithPath:soundFilePath];
        NSLog(@"exists:%d",[[NSFileManager defaultManager] fileExistsAtPath:soundFilePath]);
        
        audioPlayer = [[AVAudioPlayer alloc] 
                       initWithContentsOfURL:soundFileURL                                    
                       error:&error];
        
        audioPlayer.delegate = self;
        
        if (error)
            NSLog(@"Error: %@", 
                  [error localizedDescription]);
        else
            [audioPlayer play];
    }
}

#pragma mark- Delegates

-(void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag
{

}

-(void)audioPlayerDecodeErrorDidOccur:(AVAudioPlayer *)player error:(NSError *)error
{

}

-(void)audioRecorderDidFinishRecording:(AVAudioRecorder *)recorder successfully:(BOOL)flag
{
    
}

-(void)audioRecorderEncodeErrorDidOccur:(AVAudioRecorder *)recorder error:(NSError *)error
{

}

@end
