--!strict
export type fireworkTypes = "Rocket" | "Crackle" | "Confetti" | "Rainbow"
export type classicFireworkTypes = "Fan" | "Display" | "Classic" | "Finale"

export type SequenceProperties = {
	Effects: {Instance},
	PlaybackSpeed: number | nil,
	EffectLifetime: number | nil,
	Pause: number | nil,
	Emit: number | nil,
	[any?]: (any?) | nil
}
export type SequenceTable = {
	[number]: SequenceProperties
}
export type properties = {
	AttachmentAlwaysFacesUp: boolean | nil,
	AttachmentCenterOfMass: boolean | nil,
	AutomaticlWeld: boolean | nil,
	Debug: boolean | nil, 
	EstimateForce: boolean | nil,
	ExplosionSequence: SequenceTable | nil,
	FireworkLifeTime: number | nil,
	LaunchSequence: SequenceTable | nil,
	Mass: number | nil,
	TimeBeforeExplosion: number | nil,
	UseCustomAttachment: boolean | nil,
	XForce: number | nil,
	YForce: number | nil,
	ZForce: number | nil,
} | nil
return nil

