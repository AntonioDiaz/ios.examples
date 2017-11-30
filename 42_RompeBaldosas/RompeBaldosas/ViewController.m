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
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
