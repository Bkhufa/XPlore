//
//  Browse.swift
//  XPlore
//
//  Created by Bryan Khufa on 01/05/21.
//

import SwiftUI

struct Browse: View {
    @EnvironmentObject var modelData: ModelData
    
    @State private var selectedShift = 0
    let shifts = ["🌄 Morning", "🌇 Afternoon"]
    
    private var gridItemLayout = [GridItem(.flexible()), GridItem(.flexible())]
    
    var filteredExplorer: [Explorer] {
        modelData.explorers.filter { explorer in
                (selectedShift == 0 ? explorer.shift == Shift.morning || explorer.shift == Shift.morningAfternoon : explorer.shift == Shift.afternoon)
            }
        }
    
    var body: some View {
        NavigationView {
            VStack {
                Picker(selection: $selectedShift, label: Text("Select Shift")) {
                    ForEach(0 ..< shifts.count) { (i) in
                        HStack {
                            Text(self.shifts[i])
                                .font(.title)
                        }.tag(i)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                
                ScrollView {
                    LazyVGrid(columns: gridItemLayout, spacing: 10) {
                        ForEach(filteredExplorer, id: \.self) { explorer in
                            NavigationLink(destination: ExplorerDetail(explorer: explorer)) {
                                ExplorerCard(explorer: explorer)
                            }
                            
                        }
                    }
                }
            }
            .padding()
            .navigationTitle("Browse")
        }
    }
}
    
    struct Browse_Previews: PreviewProvider {
        static var previews: some View {
            Browse()
                .environmentObject(ModelData())
        }
    }
