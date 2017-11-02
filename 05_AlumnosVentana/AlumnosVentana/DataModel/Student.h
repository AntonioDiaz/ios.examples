//
//  Student.h
//  AlumnosVentana
//
//  Created by cice on 27/10/17.
//  Copyright © 2017 cice. All rights reserved.
//

#ifndef Student_h
#define Student_h


#endif /* Student_h */

@interface Student:NSObject {
    NSString * nombre;
    int edad;
    float nota;
    NSMutableArray *examenesTeoricos;
    NSDictionary *examenPractico;
}

@property float nota;
@property NSString *nombre;
@property int edad;

- (id) initWithName: (NSString *) name andEdad: (int) age;
- (void) guardarNuevaNota:(int) nota;
- (void) guadarProyecto:(int) nota;
- (BOOL) calculaNota;
- (NSString *) imprimExamenes;
- (void) lanzaException;

@end
