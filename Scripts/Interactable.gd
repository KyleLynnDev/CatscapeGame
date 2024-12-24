extends Area3D


class_name Interactable;


#emmited when Interactor starts looking at me 
signal focused(interactor: Interactor)

#emmited when Interactor stops looking at me 
signal unfocused(interactor: Interactor)

#emmited when Interactor interacts with me 
signal interacted(interactor: Interactor)
