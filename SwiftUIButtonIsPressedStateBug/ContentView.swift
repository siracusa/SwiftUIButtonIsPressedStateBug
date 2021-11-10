//
//  ContentView.swift
//  SwiftUIButtonIsPressedStateBug
//
//  Created by John Siracusa on 11/10/21.
//

import SwiftUI

struct ContentView: View, DropDelegate {
    @State var highlighted = false

    var body: some View {
        HStack(alignment: .center, spacing: 20, content: {
            Button(action: {
            
            }) {
                Text("Hello")
                .foregroundColor(highlighted ? Color.red : Color.white)
                .font(.system(size: 40))
                .frame(width: 200, height: 200, alignment: .center)
            }
            .buttonStyle(AppButtonStyle())
            .onDrop(of: [ .data ], delegate: self)
        })
    }
    
    func dropEntered(info: DropInfo) {
        self.highlighted = true
    }

    func dropExited(info: DropInfo) {
        self.highlighted = false
    }

    func dropUpdated(info: DropInfo) -> DropProposal? {
        if self.highlighted {
            return DropProposal(operation: .move)
        }

        return DropProposal(operation: .cancel)
    }

    func performDrop(info: DropInfo) -> Bool {
        self.highlighted = false
        return true
    }
}

struct AppButtonStyle : ButtonStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .foregroundColor(Color.white)
            .background(configuration.isPressed ? Color.blue : Color.green)
            .scaledToFit()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
