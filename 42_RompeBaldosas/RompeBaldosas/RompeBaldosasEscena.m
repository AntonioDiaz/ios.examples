#import "RompeBaldosasEscena.h"
#import "FinJuegoScene.h"

static const uint32_t categoriaPelota = 0x1 << 0; //0000000000.0000000000.0000000000.01
static const uint32_t categoriaBordeInferior = 0x1 << 1; //0000000000.0000000000.0000000000.10
static const uint32_t categoriaLadrillo = 0x1 << 2; //0000000000.0000000000.0000000001.00

@implementation RompeBaldosasEscena

-(id)initWithSize:(CGSize)size {
    if (self = [super initWithSize:size]) {
        //eliminamos la gravedad, que esta por defecto en -9.8
        self.physicsWorld.gravity = CGVectorMake(0.0, 0.0);
        //
        SKSpriteNode *fondoDePantalla = [SKSpriteNode spriteNodeWithImageNamed:@"bg.png"];
        //punto central de la pantalla.
        fondoDePantalla.position = CGPointMake(self.frame.size.width/2, self.frame.size.height/2);
        [self addChild:fondoDePantalla];
        //creamos el borde para que rebote la pelota.
        SKPhysicsBody *bordeJuego = [SKPhysicsBody bodyWithEdgeLoopFromRect:self.frame];
        //Le decimos a la pelota que este el el cuerpo principal
        self.physicsBody = bordeJuego;
        //la pelota no debe perder la velocidad al colisionar.
        self.physicsBody.friction = 0.0;
        //creamos la pelota.
        SKSpriteNode *pelota = [SKSpriteNode spriteNodeWithImageNamed:@"ball.png"];
        
        pelota.name = @"Peloata";
        pelota.position = CGPointMake(self.frame.size.width/3, self.frame.size.height/3);
        
        [self addChild:pelota];
        
        //configuramos la dinamica de la pelota.
        pelota.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:pelota.frame.size.width/2];
        pelota.physicsBody.friction = 0.0;
        pelota.physicsBody.restitution = 1.0;
        pelota.physicsBody.linearDamping = 0.0;
        pelota.physicsBody.allowsRotation = false;
        //lanzamos la pelota
        [pelota.physicsBody applyImpulse:CGVectorMake(20.0, 5.0)];
        //creamos las mascaras
        pelota.physicsBody.categoryBitMask = categoriaPelota;
        pelota.physicsBody.contactTestBitMask = categoriaLadrillo | categoriaBordeInferior;
        
        //construimos la raqueta
        SKSpriteNode *raqueta = [[SKSpriteNode alloc] initWithImageNamed:@"paddle"];
        raqueta.name = @"raqueta";
        raqueta.position = CGPointMake(CGRectGetMidX(self.frame), self.frame.size.height * 0.2);
        [self addChild:raqueta];
        
        
        //le añadimos un cuerpo fisico para darle los atributos.
        raqueta.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:raqueta.frame.size];
        raqueta.physicsBody.friction = 0.2;
        raqueta.physicsBody.restitution = 0.4;
        
        //no queremos que se mueva la raqueta, solo cuando lo hace el usuario.
        raqueta.physicsBody.dynamic = false;
        
        //añadimos los ladrillos
        int numeroDeBloque = 3;
        int anchoDeBloque = [SKSpriteNode spriteNodeWithImageNamed:@"block.png"].size.width;
        float padding = 20.0;
        float offset = (self.frame.size.width - (numeroDeBloque * anchoDeBloque + padding * (numeroDeBloque -1))) / 2;
        for (int i=0; i<numeroDeBloque; i++) {
            SKSpriteNode *bloque = [SKSpriteNode spriteNodeWithImageNamed:@"block.png"];
            bloque.position = CGPointMake(offset + padding * (i-1) + anchoDeBloque*i - anchoDeBloque/2, self.frame.size.height * 0.8);
            bloque.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:bloque.frame.size];
            bloque.name = @"bloque";
            bloque.physicsBody.friction = 0;
            [self addChild:bloque];
            bloque.physicsBody.categoryBitMask = categoriaLadrillo;
        }
        //añadimos un borde inferior.
        CGRect rectanguloInferior = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, 1);
        SKNode *nodoBordeInferior = [SKNode node];
        nodoBordeInferior.physicsBody = [SKPhysicsBody bodyWithEdgeLoopFromRect:rectanguloInferior];
        nodoBordeInferior.physicsBody.categoryBitMask = categoriaBordeInferior;
        [self addChild:nodoBordeInferior];
        //queremos que nos avisen cuando haya colision
        self.physicsWorld.contactDelegate = self;
        
    }
    
    return self;
}

#pragma mark - metodos que detectan touches en la pantalla
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    //cogemos cualquier elemento del set
    UITouch *toque = [touches anyObject];
    CGPoint localizacionDelToque = [toque locationInNode:self];
    //le preguntamos a nuestro mundo que cuerpo esta en ese punto.
    SKPhysicsBody* cuerpoTocado = [self.physicsWorld bodyAtPoint:localizacionDelToque];
    if (cuerpoTocado && [cuerpoTocado.node.name isEqualToString:@"raqueta"]) {
        NSLog(@"Empezamos a arrastrar la raqueta");
        estoyTocandoRaqueta = true;
    }
}

-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    if(estoyTocandoRaqueta) {
        //cogemos la localizacion
        UITouch *toque = [touches anyObject];
        CGPoint puntoToque = [toque locationInNode:self];
        CGPoint puntoPrevioToque = [toque previousLocationInNode:self];
        //queremos coger el nodo de la raqueta y cambiar su posicion (frame)
        SKSpriteNode* raqueta = (SKSpriteNode *)[self childNodeWithName:@"raqueta"];
        //cambiamos la posicion
        int nuevaPosicionX = raqueta.position.x + puntoToque.x - puntoPrevioToque.x;
        //verificar que la raqueta no se salga fuera.
        nuevaPosicionX = MAX(nuevaPosicionX, raqueta.size.width/2);
        nuevaPosicionX = MIN(nuevaPosicionX, self.size.width - raqueta.size.width/2);
        raqueta.position = CGPointMake(nuevaPosicionX, raqueta.position.y);
    }
}

-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    estoyTocandoRaqueta = false;
}

#pragma mark - SKPhysicsContactDelegate
- (void)didBeginContact:(SKPhysicsContact *)contact {
    //declaramos 2 cuerpos para ordenarlos
    SKPhysicsBody *primerBody;
    SKPhysicsBody *segundoBody;
    //ordenamos los bodys
    if (contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask) {
        primerBody = contact.bodyA;
        segundoBody = contact.bodyB;
    } else {
        primerBody = contact.bodyB;
        segundoBody = contact.bodyA;
    }
    //comprobamos si la pelota chocó contra el borde inferior.
    if (primerBody.categoryBitMask == categoriaPelota && segundoBody.categoryBitMask == categoriaBordeInferior) {
        //enviar a un jugador a la escena FinJuegoScene
        FinJuegoScene *finJuegoScene = [[FinJuegoScene alloc] initWithSize:self.frame.size conResultado:false];
        [self.view presentScene:finJuegoScene];
    }
    //comprobamos si la pelota chocó contra un ladrillo.
    if (primerBody.categoryBitMask == categoriaPelota && segundoBody.categoryBitMask == categoriaLadrillo) {
        [segundoBody.node removeFromParent];
        //comprobamos si quedan ladrillos
        BOOL quedanLadrillos = false;
        for (SKNode *nodo in self.children) {
            if ([nodo.name isEqualToString:@"bloque"]) {
                quedanLadrillos = true;
            }
        }
        if (!quedanLadrillos) {
            //termina el juego: has ganado.
            FinJuegoScene *finJuegoScene = [[FinJuegoScene alloc] initWithSize:self.frame.size conResultado:true];
            [self.view presentScene:finJuegoScene];
        }
    }
}


@end
