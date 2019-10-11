module Resizable
    def hero
        self.image.variant(resize: "2262x686!" ).processed
    end

    def thumbnail
        self.image.variant(resize: "640x426!" ).processed
    end

    def small
        self.image.variant(resize: "940x726!" ).processed
    end

    def large
        self.image.variant(resize: "1540x1326!" ).processed
    end
end