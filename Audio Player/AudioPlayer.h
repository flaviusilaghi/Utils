//
//  AudioPlayer.h
//  Contact Management
//
//  Created by silaghi flaviu on 6/1/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

@protocol AudioPlayerProtocol;
@interface AudioPlayer : NSObject  <AVAudioRecorderDelegate, AVAudioPlayerDelegate> 
{
    AVAudioRecorder *audioRecorder;
    AVAudioPlayer *audioPlayer;
    NSString *soundFilePath;
}

@property(nonatomic,retain) id<AudioPlayerProtocol> delegate;

-(id) initWithMemoName:(NSString*) name;
-(void) recordAudio;
-(void) stop;
-(void) playAudio;

@end

@protocol AudioPlayerProtocol <NSObject>

-(void)didFinishRecording;

@end
