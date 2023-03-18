-- MARK: - Shared

-- MARK: - Components
COMPONENT = {
    TRANSFORM = 'TRANSFORM',
    INPUT     = 'INPUT',
    GUN       = 'GUN',
    ROTATE    = 'ROTATE'
}

-- MARK: - Ecosystems
ECOSYSTEM = {
}

-- MARK: - Events
EVENT = {
}

-- MARK: - Assets

-- MARK: - Entities
require('entities.player')
require('entities.bullet')

-- MARK: - Systems
require('systems.inputSystem')
require('systems.inputMovementSystem')
require('systems.mouseRotationSystem')
require('systems.renderSystem')
require('systems.inputShootSystem')
require('systems.bulletMovementSystem')