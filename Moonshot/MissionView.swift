//
//  MissionView.swift
//  Moonshot
//
//  Created by Muhammad Arslan Nasr on 10/07/2024.
//

import SwiftUI

struct MissionView: View {
    
    struct CrewMember {
        let role: String
        let astronaut: Astronaut
    }
    
    let mission: Mission
    let crew: [CrewMember]
    
    init(mission: Mission, astronauts: [String: Astronaut]) {
        
        self.mission = mission
        
        self.crew = mission.crew.map{ member in
        
            if let astronaut = astronauts[member.name]{
                return CrewMember(role: member.role, astronaut: astronaut)
            }else{
                fatalError("Missing \(member.name)")
            }
            
        }
    }
    
    var body: some View {
        ScrollView{
            
            VStack{
                
                Image(mission.image)
                    .resizable()
                    .scaledToFit()
                    .containerRelativeFrame(.horizontal) { width, axis in
                        
                        width * 0.6
                    }
                
                
                
                
                VStack(alignment: .leading){
                    
                    Rectangle()
                        .frame(height: 2)
                        .foregroundStyle(.lightBackground)
                        .padding(.vertical)
                    
                    Text("Missing Highligts")
                        .font(.title.bold())
                        .padding(.bottom, 5)
                    
                    Text(mission.description)
                        .foregroundStyle(.white.opacity(0.5))
                    
                    Rectangle()
                        .frame(height: 2)
                        .foregroundStyle(.lightBackground)
                        .padding(.vertical)
                    
                    Text("Crew")
                        .font(.title.bold())
                        .padding(.bottom, 5)
                    
                }
                .padding(.horizontal)
                
               
                
                ScrollView(.horizontal, showsIndicators: false){
                    
                    HStack{
                        
                        ForEach(crew,id: \.role) { crewMember in
                            
                            NavigationLink{
                                AstronautView(astronaut: crewMember.astronaut)
                            } label:{
                                HStack{
                                    
                                    Image(crewMember.astronaut.id)
                                        .resizable()
                                        .frame(width: 104,height: 72)
                                        .clipShape(Capsule())
                                        .overlay(
                                        Capsule()
                                            .strokeBorder(.white,lineWidth: 1)
                                        )
                                    
                                    VStack(alignment: .leading){
                                        Text(crewMember.astronaut.name)
                                            .foregroundStyle(.white)
                                            .font(.headline)
                                        
                                        Text(crewMember.role)
                                            .foregroundStyle(.secondary)
                                        
                                    }
                                    
                                }
                                .padding(.horizontal)
                            }
                            
                        }
                        
                    }
                    
                }
                
            }
            .padding(.bottom)
            
        }
        .navigationTitle(mission.displayName)
        .navigationBarTitleDisplayMode(.inline)
        .background(.darkBackground)
       
    }
}

#Preview {
    
    let missions: [Mission] = Bundle.main.decode("missions.json")
    let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    
  return  MissionView(mission: missions[0],astronauts: astronauts)
        .preferredColorScheme(.dark)
}
