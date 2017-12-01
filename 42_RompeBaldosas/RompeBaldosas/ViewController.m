#import "ViewController.h"
#import "RompeBaldosasEscena.h"

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    SKView *skView = (SKView *) self.view;
    
    if (!skView.scene) {
        skView.showsFPS = true;
        skView.showsNodeCount = true;
        //configuramos la escena
        SKScene* escena = [RompeBaldosasEscena sceneWithSize:skView.frame.size];
        escena.scaleMode = SKSceneScaleModeAspectFit;
        //lanzamos la escena
        [skView presentScene:escena];
        
        NSError *error = nil;
        NSURL *urlMusica = [[NSBundle mainBundle] URLForResource:@"background-music-aac" withExtension:@"caf"];
        self.musicaDeFondo = [[AVAudioPlayer alloc] initWithContentsOfURL:urlMusica error:&error];
        self.musicaDeFondo.numberOfLoops = -1;
        [self.musicaDeFondo prepareToPlay];
        [self.musicaDeFondo play];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
