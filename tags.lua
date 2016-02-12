Tags = {
	list = {
		 'red', 'fruit', 'yummy', 'shiny', 'nutritious',
		 'Italy', 'green', 'water', 'blue sky', 'rocks',
		 'crunchy', 'juicy', 'growing', 'Wisconsin', 'Croatia', 'Arizona', 'winter', 'sunset',  'trees', 'Madison' --, 'nature', 'white', 'snow', 'Southwest', 'people', 'Rome' , 'Korcula', 'crowd', 'Grand Canyon National Park', 'Milwaukee', 'Assisi', 'blue', 'flowers', 'architecture', 'ice', 'church', 'yellow', 'desert', 'blur', 'Costa Rica', 'Oman', 'clouds', 'religion', 'animal', 'rural', 'sea', 'famous', 'brown', 'mountains', 'New York City', 'nyc', 'Pisa', 'wall', 'colorful', 'natural', 'Canada', 'Dubrovnik', 'Roma', 'tree', 'beach', 'countryside', 'Guanacaste', 'sunrise', 'orange', 'Taiwan', 'Wisconsin State Capitol Building', 'dusk', 'early', 'geology', 'South Rim', 'spring', 'trail', 'view', 'city', 'Italia', 'mountain', 'cold', 'country', 'Florence', 'pink', 'sports', 'urban', 'empty', 'shadow', 'skyline', 'street', 'traffic', 'flower', 'tourists', 'hill', 'Nosara', 'road', 'statue', 'boat', 'lake', 'Leaning Tower of Pisa', 'night', 'sign', 'dome', 'Hotel Lagarta Lodge', 'Manhattan', 'old', 'person', 'Scotland', 'farming', 'light', 'silhouette', 'UK', 'vegetation', 'Adriatic Sea', 'Edinburgh', 'Taipei', 'the Vatican', 'wind', 'building', 'saguaro cactus', 'transportation', 'zoo', 'Asia', 'morning', 'sky', 'St. Peter\'s Basilica', 'alley', 'field', 'hiking', 'lights', 'long exposure', 'Phoenix', 'plant', 'Wahiba Sands', 'weather', 'bike', 'black', 'formation', 'fresh', 'group', 'sailboat', 'seasons', 'bicycle', 'bright', 'grass', 'Lake Mendota', 'Milwaukee Art Museum', 'outdoors', 'Pacific Ocean', 'plants', 'tulip', 'ancient', 'bird', 'brick', 'needles', 'reflection', 'RMNP', 'Rocky Mountain National Park', 'sand', 'shutters', 'sunny', 'texture', 'window', 'animals', 'curve', 'downtown', 'dry', 'erosion', 'government', 'hills', 'landscape', 'leaves', 'lush', 'prickles', 'Roman Coliseum', 'sun', 'the Colosseum', 'waves', 'England', 'evergreen', 'farm', 'flag', 'Hallett Peak', 'lines', 'London', 'mammal', 'man', 'Muscat', 'park', 'path', 'purple', 'roof', 'Sedona', 'tile roof', 'walking', 'arch', 'bridge', 'cactus', 'cathedral', 'crowded', 'fog', 'Holy Hill', 'interior', 'Ireland', 'Lake Michigan', 'looking up', 'North Rim', 'Playa San Juanillo', 'pond', 'restaurant', 'storm', 'tower', 'tropical', 'alpine lake', 'beam', 'beer', 'hockey', 'net', 'ocean', 'pattern', 'peaceful', 'Perugia', 'pillars', 'red rocks', 'river', 'shopping', 'sidewalk', 'signs', 'square', 'sunflowers', 'taxi', 'tourism', 'wooden', 'blizzard', 'buildings', 'Chinese', 'Christianity', 'coast', 'Czech Republic', 'floral', 'hand', 'hanging', 'Henry Vilas Zoo', 'public transportation', 'seaside', 'statues', 'summer', 'three', 'travel', 'Tuscany', 'windy', 'angle', 'autumn', 'Basilica of Holy Hill', 'biking', 'boats', 'bunch', 'Cesky Krumlov', 'child', 'cross', 'crosswalk', 'dark', 'fall', 'food', 'garden', 'geometry', 'haze', 'historic', 'identical', 'market', 'pale', 'palm trees', 'Piazza del Duomo', 'predator', 'quiet', 'round', 'shape', 'table', 'tile', 'Times Square', 'unusual', 'walkway', 'windows', 'woman', 'aged', 'biker', 'black and white', 'bloom', 'blurry', 'Central Park', 'clear', 'closeup', 'cloudy', 'contrast', 'dangerous', 'Desert View', 'dirt', 'Dream Lake', 'Duomo', 'ferry', 'FFTA', 'Firenze', 'fishing', 'flags', 'frozen', 'grainy', 'large', 'mist', 'mosque', 'nature reserve'
	},

	rand = function(self)
		return math.random(table.getn(self.list))
	end,

	print = function(self, tagIdx, x, y)
		love.graphics.print(self.list[tagIdx], x, y - 30)
	end,

	getScore = function(self, idx, destroy)
		if idx < 6 then
			return destroy * 100
		elseif idx < 11 then
			return destroy * -100
		else 
			return 1
		end
	end
}