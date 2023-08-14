return function()
    local dict
    local _dict = require(script.Parent)
    beforeEach(function()
        dict = _dict.new()
    end)

    local function checkEqual(arr1, arr2)
        if #arr1 ~= #arr2 then
            return false
        end

        for i = 1, #arr1 do
            if arr1[i] ~= arr2[i] then
                return false
            end
        end

        return true
    end



    describe("dict", function()
        it("should work", function()
            dict:init({'a', 1}, {'b', 2}, {'c', 3}, {'d', 4})
            expect(dict:get('a')).to.equal(1)
            expect(dict:get('b')).to.equal(2)
            dict:set('c', 1)
            expect(dict:get('c')).to.equal(1)
            dict:set('a', 0)
            dict:set('d', nil)
            expect(dict:get('d')).to.equal(nil)

            local arr1 = {}
            local arr2 = {}
            for k, v in dict:pairs() do
                table.insert(arr1, k)
                table.insert(arr2, v)
            end

            print(arr1)
            print(arr2)
            expect(checkEqual(arr1, {'b', 'c', 'a'})).to.equal(true)
            expect(checkEqual(arr2, {2, 1, 0})).to.equal(true)
        end)
    end)
end