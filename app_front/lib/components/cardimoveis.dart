import 'package:flutter/material.dart';

class CardImoveis extends StatelessWidget {
  const CardImoveis({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: SizedBox(
        width: 280,
        child: Card(
          child: Column(     
            children: [
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(10),
                    ),
                    child: Image.network(
                      'https://picsum.photos/280/135/',
                      width: double.infinity,
                      height: 135,
                      fit: BoxFit.cover
                    ),
                  ),
                  const Positioned(
                    bottom: 10,
                    left: 10, 
                    child: Text(
                      'Texto Sobre a Imagem',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        shadows: [
                          Shadow(
                            blurRadius: 5.0,
                            color: Colors.black45,
                            offset: Offset(2, 2),
                          ),
                        ],
                      ),
                    ),
                  ),            
                ],
              ),
                                
              const Padding(
                padding: EdgeInsets.all(10.0),
                child: Row(                      
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [   
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            // textBaseline: TextBaseline.alphabetic,
                            children: [
                              Text(
                                '3', 
                                style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.w500
                                ),
                              ),
                              Padding(padding: EdgeInsets.only(left: 3)), 
                              Icon(Icons.bed_outlined),                                                                   
                              Padding(padding: EdgeInsets.only(left: 5)),    
      
                              Text(
                                '3', 
                                style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.w500
                                ),
                              ),
                              Padding(padding: EdgeInsets.only(left: 3)),                                    
                              Icon(Icons.shower_outlined),                                                                                                         
                              Padding(padding: EdgeInsets.only(left: 5)),  
      
                              Text(
                                '5', 
                                style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.w500
                                ),
                              ),
                              Padding(padding: EdgeInsets.only(left: 3)),                                    
                              Icon(Icons.directions_car_outlined),                                                                                                         
                              Padding(padding: EdgeInsets.only(left: 5)),  
                          
                            ],
                          ),
      
                          Padding(padding: EdgeInsets.only(top: 10)),
                          Text(
                            'Candeias Premiun Residencial', 
                            style: TextStyle(fontSize: 15.5),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )
              
            ],
          ),
        ),
      ),
    );
  }
}