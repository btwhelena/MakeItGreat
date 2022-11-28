//
//  UndoButton.swift
//  DailyDoodle
//
//  Created by Maria Letícia Dutra de Oliveira on 26/11/22.
//

import SwiftUI

struct UndoButton: View {
    @Environment(\.undoManager) private var undoManager
    
    var body: some View {
        Button(action: {
            undoManager?.undo()
        },
        label: {
            Image(systemName: "arrow.counterclockwise.circle")
                .resizable()
                .scaledToFit()
                .frame(width: 40, height: 40)
                .foregroundColor(Theme.pinkCTA)

        })
    }
}

struct UndoButton_Previews: PreviewProvider {
    static var previews: some View {
        UndoButton()
    }
}
