#import "FinJuegoScene.h"
#import "RompeBaldosasEscena.h"

@implementation FinJuegoScene

-(instancetype)initWithSize:(CGSize)size conResultado:(BOOL)resultado {
    if (self = [super initWithSize:size]){
        //creamos el fondo
        SKSpriteNode *nodoFondo = [SKSpriteNode spriteNodeWithImageNamed:@"bg.png"];
        nodoFondo.position = CGPointMake(self.frame.size.width/2, self.frame.size.height/2);
        [self addChild:nodoFondo];
        //creamos el texto
        SKLabelNode *textoFinal = [SKLabelNode labelNodeWithText:@"Helvetica Neue-Bold"];
        textoFinal.fontSize = 42;
        textoFinal.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
        [self addChild:textoFinal];
        if (resultado) {
            textoFinal.text = @"HAS GANADO!!!";
        } else {
            textoFinal.text = @"LOOOOSER :')";
        }
    }
    return self;
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    RompeBaldosasEscena *rompeBaldosasScene = [[RompeBaldosasEscena alloc] initWithSize:self.frame.size];
    [self.view presentScene:rompeBaldosasScene];
}

@end
