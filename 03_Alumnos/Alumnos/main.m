//
//  main.m
//  Alumnos
//
//  Created by cice on 25/10/17.
//  Copyright © 2017 cice. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

#define MINIMO_PRACTICA 4
#define PORCENTAJE_TEORIA 30
#define PORCENTAJE_PRACTICA 70

@interface Persona: NSObject
{
    NSString * nombre;
    int edad;
}
@property NSString * nombre;
- (void) imprimir;
- (id) initWithName: (NSString *) name andEdad: (int) age;
@end

@implementation Persona
@synthesize nombre;
#pragma mark metodos de la clase.
- (void) imprimir {
    NSLog(@"Me llamo %@ y tengo %i años", nombre, edad);
}
- (id) initWithName: (NSString *) name andEdad: (int) age {
    self = [super init];
    self.nombre = name;
    edad = age;
    return self;
}
@end

@interface Alumno: Persona
{
    float nota;
    NSMutableArray *examenesTeoricos;
    //contiene la nota y la fecha
    NSDictionary *examenPractico;
}
@property float nota;
- (id) initWithName: (NSString *) name andEdad: (int) age andNota:(float) nota;
- (void) guardarNuevaNota:(int) nota;
- (void) guadarProyecto:(int) nota;
- (BOOL) calculNota;
- (void) imprimExamenes;
- (void) lanzaException;
@end

@implementation Alumno
@synthesize nota;
- (void) imprimir {
    NSLog(@"Imprime el Alumno: ");
    [super imprimir];
    NSLog(@"la nota es %f", nota);
}
- (id) initWithName: (NSString *) name andEdad: (int) age andNota:(float) nota {
    examenesTeoricos = [[NSMutableArray alloc] init];
    
    self = [super initWithName:name andEdad:age];
    self.nota = nota;
    return self;
}
- (void) guardarNuevaNota:(int) nota {
    NSDate *fechaAhora = [NSDate date];
    NSNumber *numberNota = [NSNumber numberWithInteger:nota];
    NSDictionary *datosExamen = [[NSDictionary alloc] initWithObjectsAndKeys:fechaAhora, @"fechaExamen", numberNota, @"notaExamen", nil];
    [examenesTeoricos addObject:datosExamen];
}
- (void) guadarProyecto:(int) nota {
    NSDate *fechaAhora = [NSDate date];
    NSNumber *numberNota = [NSNumber numberWithInteger:nota];
    examenPractico = [[NSDictionary alloc] initWithObjectsAndKeys:fechaAhora, @"fechaExamen", numberNota, @"notaExamen", nil];
}
- (BOOL) calculNota {
    int examenPracticoInt = [[examenPractico objectForKey:@"notaExamen"]integerValue];
    if (examenPracticoInt<MINIMO_PRACTICA) {
        return false;
    } else {
        int sumaTeoria = 0;
        for (NSDictionary *myDictionary in examenesTeoricos) {
            int notaTeoriaInt = [[myDictionary objectForKey:@"notaExamen"]integerValue];
            sumaTeoria += notaTeoriaInt;
        }
        float notaTeoriaMedia = sumaTeoria / [examenesTeoricos count];
        nota = notaTeoriaMedia * PORCENTAJE_TEORIA/100 + examenPracticoInt * PORCENTAJE_PRACTICA/100;
        if (nota>=5) {
            return true;
        } else {
            return false;
        }
        return true;
    }
    return true;
}
- (void)lanzaException {
    @try {
        [examenesTeoricos objectAtIndex:10];
    } @catch (NSException *exception) {
        NSLog(@"%@ ",exception.name);
        NSLog(@"Reason: %@ ",exception.reason);
    } @finally {
        NSLog(@"@@finaly Always Executes");
    }
}

-(NSString *) contenidoArchivo {
    //NSFileManager *fileManager = [NSFileManager defaultManager];
    NSBundle *myFiles = [NSBundle mainBundle];
    NSString *filePassExam;
    if (nota>5) {
        filePassExam = [[myFiles resourcePath]stringByAppendingPathComponent:@"apto.txt"];
    } else {
        filePassExam = [[myFiles resourcePath]stringByAppendingPathComponent:@"no_apto.txt"];
    }
    NSError *error;
    NSString *fileContent = [NSString stringWithContentsOfFile:filePassExam encoding:NSUTF8StringEncoding error:&error];
    if(error) {
        NSLog(@"Ha ocurrido un error %@", error);
    } else {
        NSLog(@"Contenido del fichero %@", fileContent);
    }
    return fileContent;
}

- (void) imprimExamenes {
    int examenPracticoInt = [[examenPractico objectForKey:@"notaExamen"]integerValue];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSLog(@"Examen practico: %d", examenPracticoInt );
    for (NSDictionary *myDictionary in examenesTeoricos) {
        int notaTeoriaInt = [[myDictionary objectForKey:@"notaExamen"]integerValue];
        NSDate *date= [myDictionary objectForKey:@"fechaExamen"];
        NSString *dateString = [dateFormatter stringFromDate:date];
        NSLog(@"%@ Examen teoria: %d", dateString, notaTeoriaInt);
    }
}
@end

int main(int argc, char * argv[]) {
    @autoreleasepool {
        NSLog(@"start");
        Persona *persona = [[Persona alloc]initWithName:@"Manolo" andEdad:23];
        [persona imprimir];
        Alumno *alumno = [[Alumno alloc]initWithName:@"Manolito" andEdad:23 andNota:10];
        [alumno imprimir];
        [alumno guadarProyecto:6];
        [alumno guardarNuevaNota:5];
        [alumno guardarNuevaNota:0];
        BOOL isApto = [alumno calculNota];
        NSLog(@"TERMINA %@", isApto ? @"APTO" : @"NO APTO" );
        [alumno imprimExamenes];
        [alumno lanzaException];
        NSString *fileContent = [alumno contenidoArchivo];
        NSLog(@"fileContent: %@", fileContent );
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
    }
}
