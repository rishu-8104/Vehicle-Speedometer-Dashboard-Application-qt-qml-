import QtQuick 2.15
import QtQuick.Controls 2.15

Window {
    visible: true
    width: 400
    height: 400
    title: "Speedometer"

    property bool engineOn: false // Boolean property to represent engine state

    Rectangle {
        width: 400
        height: 400
        gradient: Gradient {
            GradientStop { position: 0.0; color: engineOn ? "lightblue" : "gray" } // Cold gradient rectangle when engine is on
            GradientStop { position: 1.0; color: "black" }
        }

        Image {
            id: speedometer
            source: "images/speedometer.png" // Speedometer base image
            anchors.fill: parent
        }

        Image {
            id: needle
            source: "images/needlered.png" // Needle image
            height: 160
            anchors.centerIn: speedometer
            anchors.verticalCenterOffset: -height/2
            rotation: engineOn ? 45 : -135 // Initial rotation based on engine state
            transformOrigin: Image.Bottom
            Behavior on rotation {
            NumberAnimation{
            duration: 2000
            }
            }
        }

        Button {
            text: engineOn ? "Engine Off" : "Engine On" // Button text based on engine state
            anchors {
                horizontalCenter: parent.horizontalCenter
                bottom: parent.bottom
                bottomMargin: 20
            }
            onClicked: {
                engineOn = !engineOn // Toggle engine state
            }
        }


    states: [
        State {
            name: "engineOff"
            PropertyChanges { target: needle; property: "rotation"; value: -135 } // Needle position when engine is off
        },
        State {
            name: "engineOn"
            PropertyChanges { target: needle; property: "rotation"; value: 10 } // Needle position when engine is on
        }
    ]

    transitions: [
        Transition {
            from: "*"
            to: "*"
            NumberAnimation {
                target: needle
                properties: "rotation"
                duration: 500 // Duration of the needle movement animation
                easing.type: Easing.OutQuad // Easing function for smooth animation
            }
        }
    ]
}
}
