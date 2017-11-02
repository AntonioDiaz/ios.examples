//
//  Student.m
//  AlumnosVentana
//
//  Created by cice on 27/10/17.
//  Copyright © 2017 cice. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Student.h"

#define MINIMO_PRACTICA 4
#define PORCENTAJE_TEORIA 30
#define PORCENTAJE_PRACTICA 70

@implementation Student

@synthesize nota;
@synthesize nombre;
@synthesize edad;

- (id) initWithName: (NSString *) name andEdad: (int) age {
    //self = [super initWithName:name andEdad:age];
    self = [super init];
    examenesTeoricos = [[NSMutableArray alloc] init];
    self.edad = age;
    self.nombre = name;
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
- (BOOL) calculaNota {
    int examenPracticoInt = [[examenPractico objectForKey:@"notaExamen"]integerValue];
    if (examenPracticoInt<MINIMO_PRACTICA) {
        return false;
    } else {
        int sumaTeoria = 0;
        if ([examenesTeoricos count]>0) {
            for (NSDictionary *myDictionary in examenesTeoricos) {
                int notaTeoriaInt = [[myDictionary objectForKey:@"notaExamen"]integerValue];
                sumaTeoria += notaTeoriaInt;
            }
            float notaTeoriaMedia = sumaTeoria / [examenesTeoricos count];
            nota = notaTeoriaMedia * 30/100 + examenPracticoInt * 70/100;
            if (nota>=5) {
                return true;
            } else {
                return false;
            }
            return true;
        }
    }
    return true;
}
- (NSString*) imprimExamenes {
    int examenPracticoInt = [[examenPractico objectForKey:@"notaExamen"]integerValue];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSLog(@"Examen practico: %d", examenPracticoInt );
    NSString *examenesTeoria = @"Examenes teoria: \n";
    NSString *examenPractico = [NSString stringWithFormat:@"Examen practico %d", examenPracticoInt];
    for (NSDictionary *myDictionary in examenesTeoricos) {
        int notaTeoriaInt = [[myDictionary objectForKey:@"notaExamen"]integerValue];
        NSDate *date= [myDictionary objectForKey:@"fechaExamen"];
        NSString *dateString = [dateFormatter stringFromDate:date];
        NSString *teoriaTemp = [NSString stringWithFormat:@"%@ examen teoria: %d\n", dateString, notaTeoriaInt];
        examenesTeoria = [examenesTeoria stringByAppendingString:teoriaTemp];
    }
    NSString *isApto = [self calculaNota]==true?@"APTO":@"NO APTO";
    NSString *resultadoString = [NSString stringWithFormat:@"Resultado \n Alumn@: %@ con %d años", nombre, edad];
    
    return [NSString stringWithFormat:@"%@\n%@\n%@\n%f\n%@", resultadoString, examenPractico, examenesTeoria, nota, isApto];
}
- (void) lanzaException {}


@end
