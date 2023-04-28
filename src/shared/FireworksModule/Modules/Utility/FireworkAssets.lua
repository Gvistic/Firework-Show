local FireworkAssets = {}

function FireworkAssets.CreateParticle(properties)
    local particle = Instance.new("ParticleEmitter")
    for property, value in pairs(properties) do
        particle[property] = value
    end
    return particle
end

function FireworkAssets.CreateLight(properties, lightType)
    local light = Instance.new(lightType)
    for property, value in pairs(properties) do
        light[property] = value
    end
    return light
end

function FireworkAssets.CreateSound(properties)
    local sound = Instance.new("Sound")
    for property, value in pairs(properties) do
        sound[property] = value
    end
    return sound
end

return FireworkAssets